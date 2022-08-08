//
//  AuthenticationBusinessLoginViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AuthenticationBusinessLoginViewController: ObservableObject, AuthenticationBusinessLoginViewControllerInterface {
    private var modelController: AuthenticationBusinessLoginModelController? = nil
    
    @Published var isSignedIn: Bool = AuthenticationService.getCurrentCompanyAccount() != nil
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        modelController = AuthenticationBusinessLoginModelController(viewController: self)
    }
    
    func resetToast() {
        showError = false
    }
    
    /// View -> Model
    func onLoginClicked(email: String, password: String) {
        if !email.isEmpty && !password.isEmpty {
            modelController?.onLoginClicked(email: email, password: password)
        }
    }
    
    /// Model -> View
    func onLoginResult(error: String?) {
        if error != nil && !error!.isEmpty {
            errorMessage = error!
            showError = true
        } else {
            isSignedIn = true
        }
    }
}
