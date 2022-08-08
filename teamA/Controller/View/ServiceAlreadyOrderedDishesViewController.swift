//
//  ServiceAlreadyOrderedDishesViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServiceAlreadyOrderedDishesViewController: ObservableObject, ServiceAlreadyOrderedDishesViewControllerInterface {
    
    private var modelController: ServiceAlreadyOrderedDishesModelController? = nil
    @Published var orderedDishes = [OrderedDishesHelper]()
    @Published var bill = 0.0
    init() {
        modelController = ServiceAlreadyOrderedDishesModelController(viewController: self)
    }
    
    /// View -> Model
    func getOrderedDishes(order: Order) {
        modelController?.getOrderedDishesOfActiveOrder(order: order)
    }
    
    func setOrderedDishesStatus(orderedDish: OrderedDish, dishesStatus: OrderDishesStatus) {
        modelController?.setOrderedDishesStatus(orderedDish: orderedDish, dishesStatus: dishesStatus)
    }
    
    /// Model -> View
    func setOrderedDishes(orderedDishesList: [OrderedDishesHelper]) {
        orderedDishes = orderedDishesList
        var count = 0.0
        if orderedDishes.count > 0 {
            for d in orderedDishes {
                count = count + (Double(d.dish.price) ?? 0.0)
            }
        }
        bill = count
    }
}
