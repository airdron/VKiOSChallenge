//
//  FeedViewController.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 10/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    private lazy var tableViewController = TableViewController()
    private lazy var gradientLayer: CAGradientLayer = self.makeGradientLayer()
    private lazy var searchBarView = SearchBarView()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return refreshControl
    }()
    private let limiter = DebouncedLimiter(limit: 0.5)
    
    private var searchBarTopConstraint: NSLayoutConstraint?
    
    var interactor: FeedInteractorInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(self.gradientLayer)
        self.view.translatesAutoresizingMaskIntoConstraints = false

        self.tableViewController.view.backgroundColor = UIColor.clear
        self.tableViewController.tableView.keyboardDismissMode = .onDrag
        self.tableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.tableViewController.tableView.register(cellClass: FeedTableViewCell.self)
        self.tableViewController.tableView.register(cellClass: FeedBottomCountTableViewCell.self)
        self.add(self.tableViewController)
        self.view.addSubview(self.searchBarView)
        self.tableViewController.tableView.contentInset.top = SearchBarView.contentHeight
        self.tableViewController.tableView.contentInset.bottom = 50
        self.tableViewController.refreshControl = self.refreshControl
        self.setupConstraints()
        self.setupHandlers()
        
        self.interactor.fetchFeed()
        self.searchBarView.configure(avatarUrl: self.interactor.avatarUrl)
    }
    
    private func setupConstraints() {
        self.searchBarTopConstraint = self.searchBarView.topAnchor.constraint(equalTo: self.topLayoutEdge)
        self.searchBarTopConstraint?.isActive = true
        self.searchBarView.leadingAnchor.constraint(equalTo: self.leftLayoutEdge).isActive = true
        self.searchBarView.trailingAnchor.constraint(equalTo: self.rightLayoutEdge).isActive = true
        self.tableViewController.view.topAnchor.constraint(equalTo: self.topLayoutEdge).isActive = true
        self.tableViewController.view.leadingAnchor.constraint(equalTo: self.leftLayoutEdge).isActive = true
        self.tableViewController.view.trailingAnchor.constraint(equalTo: self.rightLayoutEdge).isActive = true
        self.tableViewController.view.bottomAnchor.constraint(equalTo: self.bottomLayoutEdge).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.view.bounds
    }
    
    private func makeGradientLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor,
            UIColor(red: 0.92, green: 0.93, blue: 0.94, alpha: 1).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        return layer
    }
    
    private func setupHandlers() {
        self.tableViewController.onScroll = { [weak self] scrollView in
            guard let self = self else { return }
            self.searchBarTopConstraint?.constant = min(0, -scrollView.contentOffset.y - SearchBarView.contentHeight)
            self.orderLayers()
            if scrollView.isApproachingToBottom, !self.tableViewController.viewModels.isEmpty {
                if !self.searchBarView.text.isEmpty {
                    self.interactor.searchNext(q: self.searchBarView.text)
                } else {
                    self.interactor.fetchNext()
                }
            }
        }
        
        self.searchBarView.onChange = { [weak self] text in
            self?.limiter.execute {
                if !text.isEmpty {
                    self?.interactor.searchFeed(q: text)
                } else {
                    self?.interactor.fetchFeed()
                }
            }
        }
    }
    
    private func orderLayers() {
        let cells = self.tableViewController.tableView.visibleCells
        var zPosition: CGFloat = 0
        cells.forEach { $0.layer.zPosition = zPosition; zPosition += 1 }
    }

    @objc
    private func refresh() {
        if !self.searchBarView.text.isEmpty {
            self.interactor.searchFeed(q: self.searchBarView.text)
        } else {
            self.interactor.fetchFeed()
        }
    }
}

extension FeedViewController: FeedInteractorOutput {
    
    func didReceive(feedViewModels: [TableCellViewModel]) {
        self.refreshControl.endRefreshing()
        let section = DefaultTableSectionViewModel.init(cellModels: feedViewModels,
                                                        headerViewModel: nil,
                                                        footerViewModel: nil)
        self.tableViewController.update(viewModels: [section])
        self.orderLayers()
    }
    
    func didReceiveNext(feedViewModels: [TableCellViewModel]) {
        self.tableViewController.append(feedViewModels, in: 0, animation: .none)
        self.orderLayers()
    }
    
    func didReceive(error: Error) {
        self.refreshControl.endRefreshing()
        self.showErrorAlert(error)
    }
    
    func startBottomLoading() {
        self.tableViewController.tableView.bottomActivityIndicator(show: true)
    }
    func stopBottomLoading() {
        self.tableViewController.tableView.bottomActivityIndicator(show: false)
    }
    
    func didUpdate(viewModel: TableCellViewModel, inCell cell: UITableViewCell) {
        guard let indexPath = self.tableViewController.tableView.indexPath(for: cell) else { return }
        self.tableViewController.update(viewModel, at: indexPath)
    }
}
