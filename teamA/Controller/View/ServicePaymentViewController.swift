//
//  ServicePaymentViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServicePaymentViewController: ObservableObject, ServicePaymentViewControllerInterface {
    private var modelController: ServicePaymentModelController? = nil
    @Published var orderedDishes = [OrderedDishesHelper]()
    @Published var bill = 0.0
    @Published var paymentSuccess = false
    @Published var showErrorMessage = false
    
    init() {
        modelController = ServicePaymentModelController(viewController: self)
    }
    
    /// View -> Mode
    func payOrder(order: Order) {
        modelController?.archiveOrder(order: order)
    }
    
    func getOrderedDishes(order: Order) {
        modelController?.getOrderedDishesOfOrder(order: order)
    }
    
    func setOrderedDishesStatus(orderedDish: OrderedDish, dishesStatus: OrderDishesStatus) {
        modelController?.setOrderedDishesStatus(orderedDish: orderedDish, dishesStatus: dishesStatus)
    }
    
    /// Model -> View
    func setOrderedDishesOfOrder(orderedDishesList: [OrderedDishesHelper]) {
        orderedDishes = orderedDishesList
               var count = 0.0
               if orderedDishes.count > 0 {
                   for d in orderedDishes {
                       count = count + (Double(d.dish.price) ?? 0.0)
                   }
               }
               bill = count
    }
    
    func setPaymentSuccess(success: Bool) {
        if success {
            paymentSuccess = true
        } else {
            showErrorMessage = true
        }
    }
}
