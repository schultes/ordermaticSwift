//
//  KitchenBarActiveOrdersModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol KitchenBarActiveOrdersViewControllerInterface {
    func setActiveOrders(matchedOrders: [Order])
}

class KitchenBarActiveOrdersModelController {
    
    private let viewController: KitchenBarActiveOrdersViewControllerInterface
    
    init(viewController: KitchenBarActiveOrdersViewControllerInterface) {
        self.viewController = viewController
    }

    func getActiveOrders(user: User) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.addOrderSnapshotListener(companyAccount: companyAccount, isActive: true) {
                activeOrders in
                var orderIds = [String]()
                for orderedDish in activeOrders {
                    orderIds.append(orderedDish.documentId!)
                }

                DatabaseService.getAllOrderDishesByStatusSnapshotListener(companyAccount: companyAccount, orderIds: orderIds, status: OrderDishesStatus.UNDONE) {
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

                        self.viewController.setActiveOrders(matchedOrders: matchedOrders)
                    }
                }
            }
        }
    }

    func setStatusOfAllOrderedDishes(orderIds: [String], status: OrderDishesStatus, user: User) {
        if orderIds.count > 0 {
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                // All undone orderedDishes
                DatabaseService.getAllOrderDishesByStatus(companyAccount: companyAccount, orderIds: orderIds, status: OrderDishesStatus.UNDONE) {
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
                        }

                        for orderedDish in matchedOrderedDishes {
                            var temp = orderedDish
                            temp.status = status
                            DatabaseService.editOrderedDish(orderedDish: temp) {
                                _ in
                            }
                        }
                    }
                }
            }
        }
    }
}
