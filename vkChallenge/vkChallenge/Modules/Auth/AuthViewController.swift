//
//  AuthViewController.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    
    private let loginService: LoginService
    var onCompletion: Action?
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: UIControl.State())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginTouch), for: .touchUpInside)
        return button
    }()
    
    init(loginService: LoginService) {
        self.loginService = loginService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VKSdk.instance()?.uiDelegate = self
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.loginButton)
        self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc
    private func loginTouch() {
        self.loginService.login { [weak self] result in
            switch result {
            case .success:
                self?.onCompletion?()
            case .failure(let error):
                self?.showErrorAlert(error)
            }
        }
    }
    
}

extension AuthViewController: VKSdkUIDelegate {
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        self.showErrorAlert(captchaError.httpError)
    }
    
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: false, completion: nil)
    }
}
