//
//  ServiceDashboardModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol ServiceDashboardViewControllerInterface {
    func setActiveOrders(orders: [Order])
}

class ServiceDashboardModelController {
    private let viewController: ServiceDashboardViewControllerInterface?
    init(viewController: ServiceDashboardViewControllerInterface?) {
        self.viewController = viewController
    }

    func getAllActiveOrders() {
        if let viewControllerObject = viewController {
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                DatabaseService.addOrderSnapshotListener(companyAccount: companyAccount, isActive: true) {
                    orders in
                    viewControllerObject.setActiveOrders(orders: orders)
                }
            }
        }
    }

    func getReadyOrderedDishesOfOrder(order: Order, callback: @escaping ([OrderedDish]) -> ()) {
        if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
            DatabaseService.getOrderDishesByStatusSnapshotListener(companyAccount: companyAccount, order: order, status: OrderDishesStatus.READY) {
                readyOrderedDishes in
                callback(readyOrderedDishes)
            }
        }
    }

    func getDishOfOrderedDish(orderDish: OrderedDish, callback: @escaping (Dish) -> ()) {
        if AuthenticationService.getCurrentCompanyAccount() != nil {
            DatabaseService.getDish(id: orderDish.dishReference) {
                dish in
                if let dishObject = dish {
                    callback(dishObject)
                }
            }
        }
    }
}
