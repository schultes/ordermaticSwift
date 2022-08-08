//
//  ServiceAddDishesToOrderModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServiceAddDishesToOrderViewControllerInterface {
    func setDishesListView(dishes: [Dish])
}

class ServiceAddDishesToOrderModelController {
    
    private let viewController: ServiceAddDishesToOrderViewControllerInterface?
    
    init(viewController: ServiceAddDishesToOrderViewControllerInterface?) {
        self.viewController = viewController
    }

    func getDishesListView(dishesType: DishesType) {
        if let viewControllerObject = viewController {
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                DatabaseService.getDishes(companyAccount: companyAccount, dishesType: dishesType) {
                    dishes in
                    viewControllerObject.setDishesListView(dishes: dishes)
                }
            }
        }
    }
}
