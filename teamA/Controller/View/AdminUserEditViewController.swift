//
//  AdminUserEditViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AdminUserEditViewController: ObservableObject, AdminUserEditViewControllerInterface {
    
    private var modelController: AdminUserEditModelController? = nil
    @Published var succeed: Bool = false
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    private var newUserRole: UserRole? = nil

    init() {
        modelController = AdminUserEditModelController(viewController: self)
    }

    func onUserRoleClicked(role: UserRole) {
        switch role {
        case .KITCHEN:
            newUserRole = .KITCHEN
        case .BAR:
            newUserRole = .BAR
        case .SERVICE:
            newUserRole = .SERVICE
        case .ADMIN:
            newUserRole = .ADMIN
        }
    }
    
    /// View -> Model
    func onSaveClicked(oldUser: User?, passwordOld: String, passwordNew: String, passwordNewRepeat: String) {

        if let oldUser = oldUser {
            let validator = Validator()
            let passwordOldTrimmed = passwordOld.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordNewTrimmed = passwordNew.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordNewRepeatTrimmed = passwordNewRepeat.trimmingCharacters(in: .whitespacesAndNewlines)
            validator.checkForPasswordEquality(passwordOne: passwordOldTrimmed, passwordTwo: oldUser.password)
            validator.checkForPasswordComplexity(password: passwordNewTrimmed)
            validator.checkForPasswordEquality(passwordOne: passwordNewTrimmed, passwordTwo: passwordNewRepeatTrimmed)
            
            if
                passwordOldTrimmed.isEmpty &&
                    passwordNewTrimmed.isEmpty &&
                    passwordNewRepeatTrimmed.isEmpty &&
                    newUserRole != nil {
                if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                    modelController?.editUser(user: User(companyReference: companyAccount.id, name: oldUser.name, password: oldUser.password, role: newUserRole!, documentId: oldUser.documentId)
                    )
                }
            
            } else if
                passwordOldTrimmed.isEmpty ||
                    passwordNewTrimmed.isEmpty ||
                    passwordNewRepeatTrimmed.isEmpty ||
                    newUserRole == nil {
                errorMessage = "All fields are requiered!"
                showError = true
            } else if !validator.isValid() {
                errorMessage = validator.getErrorMessages().joined(separator: " / ")
                showError = true
            } else {
                if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                    modelController?.editUser(user: User(companyReference: companyAccount.id, name: oldUser.name, password: passwordNewTrimmed, role: newUserRole!, documentId: oldUser.documentId)
                    )
                }
            }
        }
        
    }
    
    func onDeleteClicked(oldUser: User?) {
        if let user = oldUser {
            modelController?.deleteUser(user: user)
        }
    }
    
    
    /// Model -> View
    func onTransactionResult() {
        succeed = true
    }
}
