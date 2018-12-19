//
//  FeedInteractor.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

protocol FeedInteractorInput: class {
    
    func fetchFeed()
    func fetchNext()
    func searchFeed(q: String)
    func searchNext(q: String)

    var avatarUrl: URL? { get }
}

protocol FeedInteractorOutput: class {
    
    func didReceive(feedViewModels: [TableCellViewModel])
    func didUpdate(viewModel: TableCellViewModel, inCell cell: UITableViewCell)

    func didReceiveNext(feedViewModels: [TableCellViewModel])
    func didReceive(error: Error)
    func startBottomLoading()
    func stopBottomLoading()
}

class FeedInteractor: FeedInteractorInput {
    
    weak var output: FeedInteractorOutput!
    
    private let apiService: ApiService
    private var usersDict: [Int64: User] = [:]
    private var groupsDict: [Int64: Group] = [:]
    private var nextFrom: String?
    private var feedIsEnded = false
    private var isLoading = false
    private var postsCount = 0
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    var avatarUrl: URL? { return self.apiService.avatarUrl }
    
    func fetchFeed() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.feedIsEnded = false
        self.isLoading = true
        self.postsCount = 0
        self.apiService.fetchFeed(nextFrom: nil) { [weak self] result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.output.didReceive(error: error)
            case .success(let feed):
                self.processData(feed: feed)
                self.output.didReceive(feedViewModels: self.prepareViewModels(posts: feed.response.items,
                                                                              isEnded: self.nextFrom == nil))
            }
        }
    }
    
    func fetchNext() {
        guard !self.isLoading, !self.feedIsEnded else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.isLoading = true
        self.output.startBottomLoading()
        self.apiService.fetchFeed(nextFrom: self.nextFrom) { [weak self] result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.output.stopBottomLoading()
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.output.didReceive(error: error)
            case .success(let feed):
                self.processData(feed: feed)
                self.output.didReceiveNext(feedViewModels: self.prepareViewModels(posts: feed.response.items,
                                                                                  isEnded: self.nextFrom == nil))
            }
        }
    }
    
    func searchFeed(q: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.feedIsEnded = false
        self.isLoading = true
        self.postsCount = 0
        self.apiService.searchFeed(q: q, nextFrom: nil) { [weak self] result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.output.didReceive(error: error)
            case .success(let feed):
                self.processData(feed: feed)
                self.output.didReceive(feedViewModels: self.prepareViewModels(posts: feed.response.items,
                                                                              isEnded: self.nextFrom == nil,
                                                                              query: q))
            }
        }
    }
    
    func searchNext(q: String) {
        guard !self.isLoading, !self.feedIsEnded else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.isLoading = true
        self.output.startBottomLoading()
        self.apiService.searchFeed(q: q, nextFrom: self.nextFrom) { [weak self] result in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.output.stopBottomLoading()
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.output.didReceive(error: error)
            case .success(let feed):
                self.processData(feed: feed)
                self.output.didReceiveNext(feedViewModels: self.prepareViewModels(posts: feed.response.items,
                                                                                  isEnded: self.nextFrom == nil,
                                                                                  query: q))
            }
        }
    }
    
    private func processData(feed: Feed) {
        self.postsCount += feed.response.items.count
        
        let users = feed.response.profiles
        users.forEach { self.usersDict[$0.id] = $0 }
        
        let groups = feed.response.groups
        groups.forEach { self.groupsDict[$0.id] = $0 }

        if let nextFrom = feed.response.nextFrom {
            self.nextFrom = nextFrom
        } else {
            self.feedIsEnded = true
            self.nextFrom = nil
        }
    }
    
    private func prepareViewModels(posts: [Post], isEnded: Bool, query: String? = nil) -> [TableCellViewModel] {
        let posts = posts.map { self.mapViewModel(post: $0, query: query) }
        if isEnded {
            let bottomCount = FeedBottomCountTableCellViewModel(count: L10n.pluralRecords(self.postsCount))
            return posts + [bottomCount]
        } else {
            return posts
        }
    }
    
    private func mapViewModel(post: Post, query: String?) -> TableCellViewModel {
        let avatarUrl: URL?
        let fullName: String
        var sourceId = post.sourceId
        if sourceId > 0 {
            avatarUrl = self.usersDict[sourceId]?.photo50
            let firstName = self.usersDict[sourceId]?.firstName ?? ""
            let lastName = self.usersDict[sourceId]?.lastName ?? ""
            fullName = firstName + " " + lastName
        } else {
            sourceId = -sourceId
            avatarUrl = self.groupsDict[sourceId]?.photo50
            let name = self.groupsDict[sourceId]?.name ?? ""
            fullName = name
        }
        
        let date: String = self.proccessDateString(post.date)
        var text: NSAttributedString = CustomFont.postText.attributesWithParagraph.make(string: post.text)
        if let query = query {
            text = self.highlightAllMatches(in: text, with: query)
        }
        let photos: [URL] = post.photos.map { $0.url }
        let likes = self.processCountString(post.likes.count)
        let comments = self.processCountString(post.comments.count)
        let reposts = self.processCountString(post.reposts.count)
        let views: String?
        if let viewsCount = post.views?.count {
            views = self.processCountString(viewsCount)
        } else {
            views = nil
        }
        
        // TODO: dangerous with screen width
        var viewModel = FeedTableCellViewModel(avatarUrl: avatarUrl,
                                               displayName: fullName,
                                               date: date,
                                               text: text,
                                               photos: photos,
                                               likes: likes,
                                               comments: comments,
                                               resposts: reposts,
                                               views: views,
                                               expanded: false,
                                               tableWidth: UIScreen.main.bounds.width)
        viewModel.expandedHandler = { [weak self] cell in
            let updatedViewModel = FeedTableCellViewModel(avatarUrl: avatarUrl,
                                                          displayName: fullName,
                                                          date: date,
                                                          text: text,
                                                          photos: photos,
                                                          likes: likes,
                                                          comments: comments,
                                                          resposts: reposts,
                                                          views: views,
                                                          expanded: true,
                                                          tableWidth: UIScreen.main.bounds.width)
            self?.output.didUpdate(viewModel: updatedViewModel, inCell: cell)
        }
        return viewModel
    }
    
    private func processCountString(_ count: Int) -> String {
        var count = count
        if count >= 1000 {
            var postfix = ""
            while count >= 1000 {
                count /= 1000
                postfix += "К"
            }
            return "\(count)" + postfix
        }
        return "\(count)"
    }
    
    private func proccessDateString(_ date: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: date)
        
        guard let yearCondition = Calendar.current.dateComponents([Calendar.Component.year], from: date).year,
              let yearCurrent = Calendar.current.dateComponents([Calendar.Component.year], from: Date()).year
            else { return "" }
        
        let hoursAndMinutesFormatter = DateFormatter.hoursAndMinutesFormatter()
        let dayFormatter = DateFormatter.dayMonthDateFormatter()
        let dayString = dayFormatter.string(from: date).lowercased().filter { !".".contains($0) }

        if yearCondition != yearCurrent {
            return dayString + " " + String(yearCondition)
        } else {
            return dayString + " в " + hoursAndMinutesFormatter.string(from: date)
        }
    }
    
    private func highlightAllMatches(in string: NSAttributedString, with query: String) -> NSAttributedString {
        var attributes = CustomFont.postText.attributesWithParagraph
        
        // TODO: For rounding corners need to work with Core Text or NSLayoutManager

        attributes[NSAttributedString.Key.foregroundColor] = UIColor(red: 0.74, green: 0.53, blue: 0.17, alpha: 1)
        attributes[NSAttributedString.Key.backgroundColor] = UIColor(red: 1, green: 0.63, blue: 0, alpha: 0.12)

        let string = NSMutableAttributedString(attributedString: string)
        let regex = try? NSRegularExpression(pattern: query, options: .caseInsensitive)
        let matches = regex?.matches(in: string.string, options: [], range: NSRange(location: 0, length: string.string.utf16.count)) ?? []
        for match in matches {
            string.addAttributes(attributes, range: match.range)
        }
        return string
    }
}
