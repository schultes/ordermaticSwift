//
//  AdminDishEditViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class AdminDishEditViewController: ObservableObject, AdminDishEditViewControllerInterface {
    
    private var modelController: AdminDishEditModelController? = nil
    @Published var succeed = false
    
    init() {
        modelController = AdminDishEditModelController(viewController: self)
    }
    
    /// View -> Model
    func onSaveClicked(dish: Dish?, dishesType: DishesType?, title: String, description: String, price: String) {
        // Edit
        if let dish = dish {
            modelController?.editDish(dish: Dish(
                companyReference: dish.companyReference,
                name: title,
                description: description,
                price: price,
                type: dish.type,
                documentId: dish.documentId
            ))
            
        // Add
        } else if let dishesType = dishesType {
            
            if let companyAccount = AuthenticationService.getCurrentCompanyAccount() {
                modelController?.addDish(dish: Dish(companyReference: companyAccount.id, name: title, description: description, price: price, type: dishesType
                ))
            }
        }
    }
    
    func onDeleteClicked(dish: Dish?) {
        if let dish = dish {
            modelController?.deleteDish(dish: dish)
        }
    }
    
    /// Model -> View
    func onTransactionResult() {
        succeed = true
    }
    
}
