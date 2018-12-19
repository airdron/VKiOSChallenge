//
//  ApiService.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

protocol ApiService {
    
    func fetchFeed(nextFrom: String?, completion: ((Result<Feed>) -> Void)?)
    func searchFeed(q: String, nextFrom: String?, completion: ((Result<Feed>) -> Void)?)
    var avatarUrl: URL? { get }
}

class ApiServiceImp: ApiService {
    
    private let networkManager: NetworkManager
    private let sessionManager: VKChallengeSessionManager

    private var defaultQueryItems: [URLQueryItem] {
        let version = URLQueryItem(name: "v", value: "5.87")
        var items = [version]
        if let token = self.sessionManager.getToken() {
            items.append(URLQueryItem(name: "access_token", value: token))
        }
        return items
    }
    
    init(networkManager: NetworkManager,
         sessionManager: VKChallengeSessionManager) {
        self.networkManager = networkManager
        self.sessionManager = sessionManager
    }
    
    var avatarUrl: URL? { return self.sessionManager.user?.photo50 }
    
    func fetchFeed(nextFrom: String?, completion: ((Result<Feed>) -> Void)?) {
        guard var urlComponents = URLComponents(url: Endpoints.feed.url, resolvingAgainstBaseURL: true) else { return }
        var items: [URLQueryItem] = []
        let queryItem = URLQueryItem(name: "filters", value: "post")
        items.append(queryItem)
        if let nextFrom = nextFrom {
            let nextFormItem = URLQueryItem(name: "start_from", value: nextFrom)
            items.append(nextFormItem)
        }
        urlComponents.queryItems = self.defaultQueryItems + items
        guard let url = urlComponents.url else { return }
        print(url.absoluteString)
        let request = URLRequest.init(url: url, method: .get)
        self.networkManager.performRequest(request: request, processData: { return try Feed(data: $0) }) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion?(.success(response))
                case .failure(let error):
                    completion?(.failure(error))

                }
            }
        }
    }
    
    func searchFeed(q: String, nextFrom: String?, completion: ((Result<Feed>) -> Void)?) {
        guard var urlComponents = URLComponents(url: Endpoints.search.url, resolvingAgainstBaseURL: true) else { return }
        var items: [URLQueryItem] = []
        let queryItem = URLQueryItem(name: "extended", value: "1")

        items.append(queryItem)
        let searchItem = URLQueryItem(name: "q", value: q)
        items.append(searchItem)

        if let nextFrom = nextFrom {
            let nextFormItem = URLQueryItem(name: "start_from", value: nextFrom)
            items.append(nextFormItem)
        }
        urlComponents.queryItems = self.defaultQueryItems + items
        guard let url = urlComponents.url else { return }
        print(url.absoluteString)
        let request = URLRequest.init(url: url, method: .get)
        self.networkManager.performRequest(request: request, processData: { return try Feed(data: $0) }) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion?(.success(response))
                case .failure(let error):
                    completion?(.failure(error))
                    
                }
            }
        }
    }
}
