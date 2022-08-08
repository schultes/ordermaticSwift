//
//  KitchenBarArchivedOrdersViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class KitchenBarArchivedOrdersViewController: ObservableObject, KitchenBarArchivedOrdersViewControllerInterface {
    private var modelController: KitchenBarArchivedOrdersModelController? = nil
    
    @Published var archivedOrders = [Order]()
    @Published var isViewActive = true
    
    init() {
        modelController = KitchenBarArchivedOrdersModelController(viewController: self)
    }
    
    func setIsViewActive(value: Bool) {
        isViewActive = value
    }
    
    /// View -> Model
    func getArchivedOrders(user: User) {
        modelController?.getArchivedOrders(user: user)
    }
    
    /// Model -> View
    func setArchivedOrders(archivedOrders: [Order]) {
        if archivedOrders.isEmpty && self.archivedOrders.isEmpty {
            return
        }
        if isViewActive {
            self.archivedOrders = archivedOrders
        }
    }
}
