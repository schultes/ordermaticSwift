//
//  ServiceCreateOrderViewController.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation


class ServiceCreateOrderViewController: ObservableObject, ServiceCreateOrderViewControllerInterface {
    private var modelController: ServiceCreateOrderModelController? = nil
    @Published var createSucceed: Bool = false
    @Published var errorMessage: String = ""
    @Published var order: Order? = nil
    @Published var showErrorMessage = false
    
    init() {
        modelController = ServiceCreateOrderModelController(viewController: self)
    }
    
    /// View -> Model
    func onCreateNewOrderClicked(tableNumber: String, user: User) {
        let tableNumberTrimed = tableNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        modelController?.addOrder(tableNumber: tableNumberTrimed, userReference: user.documentId!, date: dateString)
    }
    
    
    /// Model -> View
    func showOrderDetails(order: Order) {
        self.order = order
        createSucceed = true
    }
    
    func showError() {
        errorMessage = "Der Tisch existiert bereits"
        showErrorMessage = true
    }
}

