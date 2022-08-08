//
//  AdminUserCreateViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AdminUserCreateViewController: ObservableObject, AdminUserCreateViewControllerInterface {
    
    private var modelController: AdminUserCreateModelController? = nil
    
    @Published var createSucceed: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var colorKitchen = ColorValue.userKitchen
    @Published var colorBar = ColorValue.userBar
    @Published var colorService = ColorValue.userService
    
    private var userRole: UserRole? = nil
    
    
    init() {
        modelController = AdminUserCreateModelController(viewController: self)
    }
    
    /// View -> Model
    func onSaveClicked(name: String, password: String, passwordRepeat: String) {
        let nameTrimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordTrimmed = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRepeatTrimmed = passwordRepeat.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let validator = Validator()
        validator.checkForPasswordComplexity(password: passwordTrimmed)
        validator.checkForPasswordEquality(passwordOne: passwordTrimmed, passwordTwo: passwordRepeatTrimmed)
        
        if
            nameTrimmed.isEmpty ||
                passwordTrimmed.isEmpty ||
                passwordRepeatTrimmed.isEmpty ||
                userRole == nil
        {
            errorMessage = "All fields are required!"
            showError = true
        } else if !validator.isValid() {
            errorMessage = validator.getErrorMessages().joined(separator: " / ")
            showError = true
        } else {
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                modelController?.addUser(user: User(companyReference: companyAccount.id, name: nameTrimmed, password: passwordTrimmed, role: userRole!))
            }
        }
    }
    
    func onUserRoleClicked(role: UserRole) {
        switch role {
        case .KITCHEN:
            colorKitchen = ColorValue.userKitchenSelected
            colorBar = ColorValue.userBar
            colorService = ColorValue.userService
            userRole = .KITCHEN
        case .BAR:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBarSelected
            colorService = ColorValue.userService
            userRole = .BAR
        case .SERVICE:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBar
            colorService = ColorValue.userServiceSelected
            userRole = .SERVICE
        case .ADMIN:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBar
            colorService = ColorValue.userService
        }
    }
    
    
    /// Model -> View
    func onTransactionResult() {
        createSucceed = true
    }
    
}
