//
//  AdminDishesOverviewModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AdminDishesOverviewViewControllerInterface {
    func setDishes(dishes: [Dish])
}

class AdminDishesOverviewModelController {
    
    private let viewController: AdminDishesOverviewViewControllerInterface
    
    init(viewController: AdminDishesOverviewViewControllerInterface) {
        self.viewController = viewController
    }

    func getDishes(dishesType: DishesType) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.addDishesSnapshotListener(companyAccount: companyAccount, dishesType: dishesType) {
                dishes in
                self.viewController.setDishes(dishes: dishes)
            }
        }
    }
}
