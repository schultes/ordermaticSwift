//
//  AdminUsersOverviewModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AdminUsersOverviewViewControllerInterface {
    func setUsers(users: [User])
}

class AdminUsersOverviewModelController {
    
    private let viewController: AdminUsersOverviewViewControllerInterface
    
    init(viewController: AdminUsersOverviewViewControllerInterface) {
        self.viewController = viewController
    }

    func getUsers() {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.addOtherUsersSnapshotListener(companyAccount: companyAccount) {
                users in
                self.viewController.setUsers(users:users)
            }
        }
    }
}
