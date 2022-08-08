//
//  KitchenBarActiveDishesModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol KitchenBarActiveDishesViewControllerInterface {
    func setActiveDishes(list: [OrderedDishesHelper])
}

class KitchenBarActiveDishesModelController {
    private let viewController: KitchenBarActiveDishesViewControllerInterface
    init(viewController: KitchenBarActiveDishesViewControllerInterface) {
        self.viewController = viewController
    }

    func getActiveDishesOfOrder(order: Order, user: User) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getAllOrderDishesByStatusSnapshotListener(companyAccount: companyAccount, orderIds: [order.documentId!], status: OrderDishesStatus.UNDONE) {
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
                    self.viewController.setActiveDishes(list: orderAndDishes)
                }
            }
        }
    }

    func setStatusOfOrderedDishes(orderedDishesIds: [String], orderReference: String) {
        if orderedDishesIds.count > 0 {
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                DatabaseService.getAllOrderDishesByStatus(companyAccount: companyAccount, orderIds: [orderReference], status: OrderDishesStatus.UNDONE) {
                    orderedDishes in
                    let matchedOrderedDishes = orderedDishes.filter {
                        orderedDish in
                        orderedDishesIds.contains(orderedDish.documentId!)
                    }

                    for orderedDish in matchedOrderedDishes {
                        var temp = orderedDish
                        temp.status = OrderDishesStatus.READY
                        DatabaseService.editOrderedDish(orderedDish: temp) {
                            _ in
                        }
                    }
                }
            }
        }
    }
}
