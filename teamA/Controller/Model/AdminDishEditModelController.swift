//
//  AdminDishEditModelController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

protocol AdminDishEditViewControllerInterface {
    func onTransactionResult()
}

public class AdminDishEditModelController {
    
    private let viewController: AdminDishEditViewControllerInterface
    
    init(viewController: AdminDishEditViewControllerInterface) {
        self.viewController = viewController
    }

    func addDish(dish: Dish) {
        DatabaseService.addDish(dish: dish) {
            dishObject in
            if dishObject != nil {
                self.viewController.onTransactionResult()
            }
        }
    }

    func editDish(dish: Dish) {
        DatabaseService.editDish(dish: dish) {
            error in
            if error == nil {
                self.viewController.onTransactionResult()
            }
        }
    }

    func deleteDish(dish: Dish) {
        DatabaseService.deleteDish(dish: dish) {
            error in
            if error == nil {
                self.viewController.onTransactionResult()
            }
        }
    }
}
