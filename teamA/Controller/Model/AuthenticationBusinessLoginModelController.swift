//
//  AuthenticationBusinessLoginModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AuthenticationBusinessLoginViewControllerInterface {
    func onLoginResult(error: String?)
}

class AuthenticationBusinessLoginModelController {
    
    private let viewController: AuthenticationBusinessLoginViewControllerInterface
    
    init(viewController: AuthenticationBusinessLoginViewControllerInterface) {
        self.viewController = viewController
    }

    func onLoginClicked(email: String, password: String) {
        AuthenticationService.signInToCompanyAccount(email: email, password: password) {
            _, error in
            self.viewController.onLoginResult(error: error)
        }
    }
}
