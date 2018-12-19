//
//  MainCoordinator.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator, AuthCoordinatorFlowPresentable, FeedCoordinatorFlowPresentable  {
    
    var coordinatorFactory: CoordinatorFactory
    var sessionManager: VKChallengeSessionManager
    private let presenter: UIWindow
    
    init(presenter: UIWindow,
         sessionManager: VKChallengeSessionManager,
         coordinatorFactory: CoordinatorFactory) {
        self.presenter = presenter
        self.sessionManager = sessionManager
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }
    
    override  func start() {
        if sessionManager.isRegistred {
            self.startFeedFlow(presenter: self.presenter)
        } else {
            self.startAuthFlow(presenter: self.presenter) { [weak self] in
                guard let self = self else { return }
                self.startFeedFlow(presenter: self.presenter)
            }
        }
    }
}
