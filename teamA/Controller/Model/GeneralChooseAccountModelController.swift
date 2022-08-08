//
//  GeneralChooseAccountModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol GeneralChooseAccountViewControllerInterface {
    func setCompanyName(company: Company)
    func setChooseAccountList(users: [User])
}

class GeneralChooseAccountModelController {
    private let viewController: GeneralChooseAccountViewControllerInterface
    
    init(viewController: GeneralChooseAccountViewControllerInterface) {
        self.viewController = viewController
    }

    func getCompanyName() {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getCompany(id: companyAccount.id) {
                company in
                if let companyObject = company {
                    self.viewController.setCompanyName(company: companyObject)
                }
            }
        }
    }

    func getChooseAcccountList() {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.addUsersSnapshotListener(companyAccount: companyAccount) {
                users in
                self.viewController.setChooseAccountList(users: users)
            }
        }
    }
}
