//
//  AuthenticationBusinessRegisterModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AuthenticationBusinessRegisterViewControllerInterface {
    func onRegisterResult(error: String?)
}

class AuthenticationBusinessRegisterModelController {
    private let viewController: AuthenticationBusinessRegisterViewControllerInterface
    init(viewController: AuthenticationBusinessRegisterViewControllerInterface) {
        self.viewController = viewController
    }

    func onRegisterClicked(companyName: String, companyAddressFirstLine: String, companyAddressSecondLine: String, companyPassword: String, adminName: String, adminEmail: String, adminPassword: String) {
        AuthenticationService.createCompanyAccount(email: adminEmail, password: companyPassword) {
            companyAccount, error in
            if let companyAccountObject = companyAccount {
                let company = Company(name: companyName, addressFirstLine: companyAddressFirstLine, addressSecondLine: companyAddressSecondLine, documentId: companyAccountObject.id)
                let user = User(companyReference: companyAccountObject.id, name: adminName, password: adminPassword, role: UserRole.ADMIN)
                DatabaseService.setCompany(id: companyAccountObject.id, company: company) {
                    error in
                    if error == nil {
                        DatabaseService.addUser(user: user) {
                            user in
                            if user == nil {
                                self.viewController.onRegisterResult(error: "Error while adding admin!")
                            } else {
                                self.viewController.onRegisterResult(error: nil)
                            }
                        }
                    } else {
                        self.viewController.onRegisterResult(error: error)
                    }
                }
            }

            if companyAccount == nil {
                self.viewController.onRegisterResult(error: error)
            }
        }
    }
}
