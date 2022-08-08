//
//  AdminUserEditModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AdminUserEditViewControllerInterface {
    func onTransactionResult()
}

class AdminUserEditModelController {
    
    private let viewController: AdminUserEditViewControllerInterface
    
    init(viewController: AdminUserEditViewControllerInterface) {
        self.viewController = viewController
    }

    func editUser(user: User) {
        DatabaseService.editUser(user: user) {
            error in
            if error == nil {
                self.viewController.onTransactionResult()
            }
        }
    }

    func deleteUser(user: User) {
        DatabaseService.deleteUser(user: user) {
            error in
            if error == nil {
                self.viewController.onTransactionResult()
            }
        }
    }
}
