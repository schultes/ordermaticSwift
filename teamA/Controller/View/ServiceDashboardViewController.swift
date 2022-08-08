//
//  ServiceDashboardViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ServiceDashboardViewController: ObservableObject, ServiceDashboardViewControllerInterface {
    
    private var modelController: ServiceDashboardModelController? = nil
    @Published var activeOrders = [Order]()
     
    init() {
        modelController = ServiceDashboardModelController(viewController: self)
        modelController?.getAllActiveOrders()
    }
    
    func setActiveOrders(orders: [Order]) {
        activeOrders = orders
    }
}
