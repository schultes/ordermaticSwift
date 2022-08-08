//
//  KitchenBarArchivedDishesViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class KitchenBarArchivedDishesViewController: ObservableObject, KitchenBarArchivedDishesViewControllerInterface {
    
    private var modelController: KitchenBarArchivedDishesModelController? = nil
     
    @Published var orderedDishes = [OrderedDishesHelper]()
    
    init() {
        modelController = KitchenBarArchivedDishesModelController(viewController: self)
    }
    
    /// View -> Model
    func getDishes(order: Order, user: User) {
        modelController?.getArchivedDishesOfOrder(order: order, user: user)
    }
    
    /// View -> Model
    func setArchivedDishesOfOrder(list: [OrderedDishesHelper]) {
        if orderedDishes.count == 0 && list.count == 0 {
            return
        }
        orderedDishes = list
    }
}
