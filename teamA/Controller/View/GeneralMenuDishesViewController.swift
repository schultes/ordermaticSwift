//
//  GeneralMenuDishesViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class GeneralMenuDishesViewController: ObservableObject, GeneralMenuDishesViewControllerInterface {
    private var modelController: GeneralMenuDishesModelController? = nil
     
    @Published var dishes = [Dish]()
    
    init() {
        modelController = GeneralMenuDishesModelController(viewController: self)
    }
    
    /// View -> Model
    func getDishes(dishesType: DishesType) {
        modelController?.getDishes(dishesType: dishesType)
    }
    
    /// Model -> View
    func setDishes(dishes: [Dish]) {
        self.dishes = dishes
    }
    
}
