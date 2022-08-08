//
//  ServiceActiveOrdersAdapterViewController.swift
//  teamA
//
//  Created by FMA1 on 30.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServiceActiveOrdersAdapterViewController: ObservableObject {
    
    @Published var hasReadyDishes = false
    @Published var typesOfDishes = Set<DishesType>()
    
    var order: Order
    
    private var modelController = ServiceDashboardModelController(viewController: nil)
    
    init(order: Order) {
        self.order = order
        modelController.getReadyOrderedDishesOfOrder(order: order) { dishes in
            if dishes.count > 0 {
                self.hasReadyDishes = true
                
                for dish in dishes {
                    self.modelController.getDishOfOrderedDish(orderDish: dish) { details in
                        self.typesOfDishes.insert(details.type)
                    }
                }  
            } else {
                self.hasReadyDishes = false
            }
        }
    }
    
    
}
