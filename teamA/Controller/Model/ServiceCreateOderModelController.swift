//
//  ServiceCreateOderModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServiceCreateOrderViewControllerInterface {
    func showOrderDetails(order: Order)
    func showError()
}

class ServiceCreateOrderModelController {
    
    private let viewController: ServiceCreateOrderViewControllerInterface
    
    init(viewController: ServiceCreateOrderViewControllerInterface) {
        self.viewController = viewController
    }

    func addOrder(tableNumber: String, userReference: String, date: String) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            let companyReference = companyAccount.id
            // Can only create new order if tableNumber does not exist already (active)
            DatabaseService.getActiveOrderByTableNumber(companyAccount: companyAccount, tableNumber: tableNumber) {
                order in
                if order != nil {
                    self.viewController.showError()
                }

                if order == nil {
                    let temp = Order(companyReference: companyReference, userReference: userReference, tableNumber: tableNumber, isActive: true, createdAt: date)
                    DatabaseService.addOrder(order: temp) {
                        result in
                        if let resultObject = result {
                            self.viewController.showOrderDetails(order: resultObject)
                        }

                        if result == nil {
                            self.viewController.showError()
                        }
                    }
                }
            }
        }
    }
}
