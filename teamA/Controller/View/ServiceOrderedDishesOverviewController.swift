//
//  ServiceOrderedDishesOverviewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServiceOrderedDishesOverviewViewController: ObservableObject, ServiceOrderedDishesOverviewViewControllerInterface {
    
    private var modelController: ServiceOrderedDishesOverviewModelController? = nil
    @Published var errorMessage = ""
    @Published var showErrorMessage = false
    @Published var saveSuccess = false
    @Published var unsavedOrderedDishes = [OrderedDish]()
    @Published var hasAlreadyOrderedDishes = false
    
    init() {
        modelController = ServiceOrderedDishesOverviewModelController(viewController: self)
    }
    
    /// View -> Model
    func sendOrder() {
        if self.unsavedOrderedDishes.count > 0 {
            modelController?.saveOrderedDishes(orderedDishes: unsavedOrderedDishes)
        } else {
            errorMessage = "Keine Gerichte ausgewählt!"
            showErrorMessage = true
        }
    }
    
    func setUnsavedOrderedDishes(dishes: [OrderedDish]) {
        unsavedOrderedDishes = dishes
    }
    
    func setOrderedDishesListener(order: Order) {
        modelController?.getReadyOrderedDishesOfOrderListener(order: order)
    }
    
    /// Model -> View
    func onOrderedDishesSave(success: Bool) {
        if success {
            saveSuccess = true
            unsavedOrderedDishes = [OrderedDish]()
        } else {
            errorMessage = "Fehler"
            showErrorMessage = true
        }
    }
    
    func setReadyOrderChange(orderedDishes: [OrderedDish]) {
        if orderedDishes.count > 0 {
            hasAlreadyOrderedDishes = true
        } else {
            hasAlreadyOrderedDishes = false
        }
    }
}
