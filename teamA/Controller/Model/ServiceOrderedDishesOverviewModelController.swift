//
//  ServiceOrderedDishesOverviewModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServiceOrderedDishesOverviewViewControllerInterface {
    func onOrderedDishesSave(success: Bool)
    func setReadyOrderChange(orderedDishes: [OrderedDish])
}

class ServiceOrderedDishesOverviewModelController {
    
    private let viewController: ServiceOrderedDishesOverviewViewControllerInterface
    
    init(viewController: ServiceOrderedDishesOverviewViewControllerInterface) {
        self.viewController = viewController
    }

    func getReadyOrderedDishesOfOrderListener(order: Order) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getOrderDishesByStatusSnapshotListener(companyAccount: companyAccount, order: order, status: OrderDishesStatus.READY) {
                readyOrderedDishes in
                self.viewController.setReadyOrderChange(orderedDishes: readyOrderedDishes)
            }
        }
    }

    func saveOrderedDishes(orderedDishes: [OrderedDish]) {
        for dish in orderedDishes {
            DatabaseService.addOrderedDish(orderedDish: dish) {
                orderedDish in
                if orderedDish != nil {
                    if orderedDishes.last! == dish {
                        self.viewController.onOrderedDishesSave(success: true)
                    }
                }

                if orderedDish == nil {
                    self.viewController.onOrderedDishesSave(success: false)
                }
            }
        }
    }
}
