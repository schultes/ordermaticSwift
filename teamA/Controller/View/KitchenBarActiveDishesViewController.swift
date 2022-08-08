//
//  KitchenBarActiveDishesViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class KitchenBarActiveDishesViewController: ObservableObject, KitchenBarActiveDishesViewControllerInterface {
    private var modelController: KitchenBarActiveDishesModelController? = nil
    
    @Published var matchedOrderedDishes = [OrderedDishesHelper]()
    @Published var changedOrderedDishes = [OrderedDish]()
    @Published var comment = ""
    
    init() {
        modelController = KitchenBarActiveDishesModelController(viewController: self)
    }
    
    func addOrderedDishToChangedOrders(order: OrderedDishesHelper) {
        changedOrderedDishes.append(order.orderedDish)
    }
    
    func removeOrderedDishFromChangedOrders(order: OrderedDishesHelper) {
        if let index = changedOrderedDishes.firstIndex(of: order.orderedDish) {
            changedOrderedDishes.remove(at: index)
        }
    }
    
    func isOrderChecked(order: OrderedDishesHelper) -> Bool {
        if changedOrderedDishes.firstIndex(of: order.orderedDish) != nil {
            return true
        } else {
            return false
        }
    }
    
    /// View -> Model
    func getActiveDishes(order: Order, user: User) {
        modelController?.getActiveDishesOfOrder(order: order, user: user)
    }
    
    func sendStatusOfOrderedDishes(order: Order) {
        if changedOrderedDishes.count > 0 {
            let orderIds = changedOrderedDishes.map { orderedDish in orderedDish.documentId!}
            modelController?.setStatusOfOrderedDishes(orderedDishesIds: orderIds, orderReference: order.documentId!)
            changedOrderedDishes = []
        }
    }
    
    /// Model -> View
    func setActiveDishes(list: [OrderedDishesHelper]) {
        if matchedOrderedDishes.count == 0 && list.count == 0 {
            return
        }
        matchedOrderedDishes = list
        changedOrderedDishes = []
        for d in matchedOrderedDishes {
            if !d.orderedDish.comment.isEmpty {
                comment = d.orderedDish.comment
            }
        }
    }
}
