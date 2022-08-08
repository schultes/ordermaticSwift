//
//  KitchenBarActiveOrdersViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class KitchenBarActiveOrdersViewController: ObservableObject, KitchenBarActiveOrdersViewControllerInterface {
    
    private var modelController: KitchenBarActiveOrdersModelController? = nil
    @Published var matchedOrders = [Order]()
    @Published var changedOrders = [Order]()
    @Published var isViewActive = true
    
    init() {
        modelController = KitchenBarActiveOrdersModelController(viewController: self)
    }
    
    func setIsViewActive(value: Bool) {
        isViewActive = value
    }
    
    func addOrderToChangedOrders(order: Order) {
        changedOrders.append(order)
    }
    
    func removeOrderFromChangedOrders(order: Order) {
        if let index = changedOrders.firstIndex(of: order) {
            changedOrders.remove(at: index)
        }
    }
    
    func isOrderChecked(order: Order) -> Bool {
        if changedOrders.firstIndex(of: order) != nil {
            return true
        } else {
            return false
        }
    }
    
    /// View -> Model
    func getActiveOrders(user: User) {
        modelController?.getActiveOrders(user: user)
    }
    
    func sendStatusOfOrders(user: User) {
        if changedOrders.count > 0 {
            let orderIds = changedOrders.map { order in order.documentId!}
            modelController?.setStatusOfAllOrderedDishes(orderIds: orderIds, status: .READY, user: user)
            changedOrders = []
        }
    }
    
    /// Model -> View
    func setActiveOrders(matchedOrders: [Order]) {
        if isViewActive {
            self.matchedOrders = matchedOrders
        }
    }
}
