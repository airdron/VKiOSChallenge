//
//  FeedModuleBuilder.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class FeedModuleBuilder {
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func makeFeedModule() -> FeedViewController {
        let interactor = FeedInteractor(apiService: self.apiService)
        let controller = FeedViewController()
        interactor.output = controller
        controller.interactor = interactor
        return controller
    }
}
