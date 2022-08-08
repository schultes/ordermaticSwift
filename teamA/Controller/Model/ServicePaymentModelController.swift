//
//  ServicePaymentModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServicePaymentViewControllerInterface {
    func setPaymentSuccess(success: Bool)
    func setOrderedDishesOfOrder(orderedDishesList: [OrderedDishesHelper])
}

class ServicePaymentModelController {
    private let viewController: ServicePaymentViewControllerInterface
    init(viewController: ServicePaymentViewControllerInterface) {
        self.viewController = viewController
    }

    func archiveOrder(order: Order) {
        var temp = order
        temp.isActive = false
        DatabaseService.editOrder(order: temp) {
            error in
            var success = true
            if error != nil {
                success = false
            }
            self.viewController.setPaymentSuccess(success: success)
        }
    }

    func getOrderedDishesOfOrder(order: Order) {
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

                    self.viewController.setOrderedDishesOfOrder(orderedDishesList: orderAndDishes)
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
