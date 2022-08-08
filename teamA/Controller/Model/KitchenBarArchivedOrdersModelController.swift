//
//  KitchenBarArchivedOrdersModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol KitchenBarArchivedOrdersViewControllerInterface {
    func setArchivedOrders(archivedOrders: [Order])
}

class KitchenBarArchivedOrdersModelController {
    
    private let viewController: KitchenBarArchivedOrdersViewControllerInterface
    
    init(viewController: KitchenBarArchivedOrdersViewControllerInterface) {
        self.viewController = viewController
    }

    func getArchivedOrders(user: User) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.addOrderSnapshotListener(companyAccount: companyAccount, isActive: false) {
                activeOrders in
                var orderIds = [String]()
                for orderedDish in activeOrders {
                    orderIds.append(orderedDish.documentId!)
                }

                DatabaseService.getAllOrderDishesOfMultipleOrdersSnapshotListener(companyAccount: companyAccount, orderIds: orderIds) {
                    orderedDishes in
                    var dishesTypes = [DishesType]()
                    if user.role == UserRole.BAR {
                        dishesTypes.append(DishesType.DRINKS)
                    } else {
                        dishesTypes += [DishesType.STARTERS, DishesType.MAIN_DISHES, DishesType.DESSERTS]
                    }

                    // Get dishes with given dishesType to check if the orderedDishes are relevant for user
                    DatabaseService.getDishesIdsByTypes(companyAccount: companyAccount, dishesTypes: dishesTypes) {
                        ids in
                        let matchedOrderedDishes = orderedDishes.filter {
                            orderedDish in
                            ids.contains(orderedDish.dishReference)
                        }.map {
                            orderedDish in
                            orderedDish.orderReference
                        }

                        let matchedOrders = activeOrders.filter {
                            order in
                            matchedOrderedDishes.contains(order.documentId!)
                        }

                        self.viewController.setArchivedOrders(archivedOrders: matchedOrders)
                    }
                }
            }
        }
    }
}
