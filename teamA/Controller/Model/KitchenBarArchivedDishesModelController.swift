//
//  KitchenBarArchivedDishesModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

protocol KitchenBarArchivedDishesViewControllerInterface {
    func setArchivedDishesOfOrder(list: [OrderedDishesHelper])
}

class KitchenBarArchivedDishesModelController {
    private let viewController: KitchenBarArchivedDishesViewControllerInterface
    init(viewController: KitchenBarArchivedDishesViewControllerInterface) {
        self.viewController = viewController
    }

    func getArchivedDishesOfOrder(order: Order, user: User) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getOrderedDishes(order: order) {
                orderedDishes in
                var dishesTypes = [DishesType]()
                if user.role == UserRole.BAR {
                    dishesTypes.append(DishesType.DRINKS)
                } else {
                    dishesTypes += [DishesType.STARTERS, DishesType.MAIN_DISHES, DishesType.DESSERTS]
                }

                var orderAndDishes = [OrderedDishesHelper]()
                DatabaseService.getDishesByTypes(companyAccount: companyAccount, dishesTypes: dishesTypes) {
                    dishes in
                    for orderedDish in orderedDishes {
                        let dish = dishes.first {
                            d in
                            d.documentId == orderedDish.dishReference
                        }

                        if let dishObject = dish {
                            orderAndDishes.append(OrderedDishesHelper(orderedDish: orderedDish, dish: dishObject))
                        }
                    }
                    self.viewController.setArchivedDishesOfOrder(list: orderAndDishes)
                }
            }
        }
    }
}
