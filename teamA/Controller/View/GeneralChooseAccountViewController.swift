//
//  GeneralChooseAccountViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class GeneralChooseAccountViewController: ObservableObject, GeneralChooseAccountViewControllerInterface {
    
    @Published var companyName: String = "Company"
    @Published var users = [User]()
    @Published var isSignedIn = true
    
    private var modelController: GeneralChooseAccountModelController? = nil
     
    init() {
        modelController = GeneralChooseAccountModelController(viewController: self)
        modelController?.getCompanyName()
        modelController?.getChooseAcccountList()
        isSignedIn = AuthenticationService.getCurrentCompanyAccount() != nil
    }
    
    /// View -> Model
    func onLogoutClicked() {
        AuthenticationService.signOutFromCompanyAccount()
        isSignedIn = false
    }
    
    
    /// Model -> View
    func setCompanyName(company: Company) {
        companyName = company.name
    }
    
    func setChooseAccountList(users: [User]) {
        self.users = users
    }
}
