//
//  GeneralUserLoginViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class GeneralUserLoginViewController: ObservableObject {
    
    @Published var isUserSignedIn = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    func onLoginClicked(passwordOne: String, correctPassword: String) {
        if passwordOne == correctPassword {
            isUserSignedIn = true
        } else {
            errorMessage = "Falsches Passwort!"
            showError = true
        }
    }
    
}
