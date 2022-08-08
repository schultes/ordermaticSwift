//
//  AdminUsersOverviewViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AdminUsersOverviewViewController: ObservableObject, AdminUsersOverviewViewControllerInterface {
    private var modelController: AdminUsersOverviewModelController? = nil
    
    @Published var users = [User]()
     
     init() {
         modelController = AdminUsersOverviewModelController(viewController: self)
        modelController?.getUsers()
     }
    
    func setUsers(users: [User]) {
        self.users = users
    }
}
