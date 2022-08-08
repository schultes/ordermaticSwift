//
//  ServiceAddDishesToOrderViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServiceAddDishesToOrderViewController: ObservableObject, ServiceAddDishesToOrderViewControllerInterface {
    
    private var modelController: ServiceAddDishesToOrderModelController? = nil
    @Published var dishesList = [Dish]()
    
    init() {
        modelController = ServiceAddDishesToOrderModelController(viewController: self)
    }
    
    /// View -> Model
    func getDishesList(dishesType: DishesType) {
        modelController?.getDishesListView(dishesType: dishesType)
    }
    
    
    /// Model -> View
    func setDishesListView(dishes: [Dish]) {
        dishesList = dishes
    }
}
