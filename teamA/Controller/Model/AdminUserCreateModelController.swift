//
//  AdminUserCreateModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AdminUserCreateViewControllerInterface {
    func onTransactionResult()
}

class AdminUserCreateModelController {
    
    private let viewController: AdminUserCreateViewControllerInterface
    
    init(viewController: AdminUserCreateViewControllerInterface) {
        self.viewController = viewController
    }

    func addUser(user: User) {
        DatabaseService.addUser(user: user) {
            userObject in
            if userObject != nil {
                self.viewController.onTransactionResult()
            }
        }
    }
}
