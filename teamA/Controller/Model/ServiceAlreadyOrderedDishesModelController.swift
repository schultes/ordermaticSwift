//
//  ServiceAlreadyOrderedDishesModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServiceAlreadyOrderedDishesViewControllerInterface {
    func setOrderedDishes(orderedDishesList: [OrderedDishesHelper])
}

class ServiceAlreadyOrderedDishesModelController {
    
    private let viewController: ServiceAlreadyOrderedDishesViewControllerInterface
    
    init(viewController: ServiceAlreadyOrderedDishesViewControllerInterface) {
        self.viewController = viewController
    }

    func getOrderedDishesOfActiveOrder(order: Order) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getAllOrderedDishesOfOrderSnapshotListener(companyAccount: companyAccount, order: order) {
                orderedDishes in
                var orderAndDishes = [OrderedDishesHelper]()
                DatabaseService.getDishes(companyAccount: companyAccount) {
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

                    self.viewController.setOrderedDishes(orderedDishesList: orderAndDishes)
                }
            }
        }
    }

    func setOrderedDishesStatus(orderedDish: OrderedDish, dishesStatus: OrderDishesStatus) {
        var temp = orderedDish
        temp.status = dishesStatus
        DatabaseService.editOrderedDish(orderedDish: temp) {
            _ in
        }
    }
}
