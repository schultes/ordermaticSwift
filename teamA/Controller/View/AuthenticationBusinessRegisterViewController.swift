//
//  AuthenticationBusinessRegisterViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AuthenticationBusinessRegisterViewController: ObservableObject, AuthenticationBusinessRegisterViewControllerInterface {
    private var modelController: AuthenticationBusinessRegisterModelController? = nil
     
    @Published var isSignedIn: Bool = AuthenticationService.getCurrentCompanyAccount() != nil
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    init() {
        modelController = AuthenticationBusinessRegisterModelController(viewController: self)
    }
    
    /// View -> Model
    func onRegisterClicked(
        companyName: String,
        companyAdressFirstLine: String,
        companyAdressSecondLine: String,
        companyPassword: String,
        companyPasswordRepeat: String,
        adminName: String,
        adminEmail: String,
        adminPassword: String,
        adminPasswordRepeat: String
    ) {
        let companyNameTrimmed = companyName.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyAdressFirstLineTrimmed = companyAdressFirstLine.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyAdressSecondLineTrimmed = companyAdressSecondLine.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyPasswordTrimmed = companyPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyPasswordRepeatTrimmed = companyPasswordRepeat.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let adminNameTrimmed = adminName.trimmingCharacters(in: .whitespacesAndNewlines)
        let adminEmailTrimmed = adminEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        let adminPasswordTrimmed = adminPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let adminPasswordRepeatTrimmed = adminPasswordRepeat.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let validator = Validator()
        validator.checkForEmailPattern(email: adminEmailTrimmed)
        validator.checkForPasswordComplexity(password: companyPasswordTrimmed)
        validator.checkForPasswordEquality(passwordOne: companyPasswordTrimmed, passwordTwo: companyPasswordRepeatTrimmed)
        
        validator.checkForPasswordComplexity(password: adminPasswordTrimmed)
        validator.checkForPasswordEquality(passwordOne: adminPasswordTrimmed, passwordTwo: adminPasswordRepeatTrimmed)
        
        if
            companyNameTrimmed.isEmpty ||
            companyAdressFirstLineTrimmed.isEmpty ||
            companyAdressSecondLineTrimmed.isEmpty ||
            companyPasswordTrimmed.isEmpty ||
            companyPasswordRepeatTrimmed.isEmpty ||
            adminNameTrimmed.isEmpty ||
            adminEmailTrimmed.isEmpty ||
            adminPasswordTrimmed.isEmpty ||
            adminPasswordRepeatTrimmed.isEmpty
        {
            errorMessage = "All fields are required!"
            showError = true
        } else if !validator.isValid() {
            errorMessage = validator.getErrorMessages().joined(separator: " / ")
            showError = true
        } else {
            modelController?.onRegisterClicked(companyName: companyNameTrimmed, companyAddressFirstLine: companyAdressFirstLineTrimmed, companyAddressSecondLine: companyAdressSecondLineTrimmed, companyPassword: companyPasswordTrimmed, adminName: adminNameTrimmed, adminEmail: adminEmailTrimmed, adminPassword: adminPasswordTrimmed)
        }

    }
    
    /// Model -> View
    func onRegisterResult(error: String?) {
        if error != nil && !error!.isEmpty {
            showError = true
        } else {
            isSignedIn = true
        }
    }
}
