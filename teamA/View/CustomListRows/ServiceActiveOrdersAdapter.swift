//
//  ServiceActiveOrdersAdapter.swift
//  teamA
//
//  Created by FMA1 on 29.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServiceActiveOrdersAdapter: View {
    
    @State var order: Order
    @State var user: User
    @State var viewController: ServiceActiveOrdersAdapterViewController
    @State var hasReadyDishes = false
    
    var body: some View {
        HStack {
            
            if !self.hasReadyDishes {
            Text("Tischnummer \(order.tableNumber)")
            .frame(maxWidth: .infinity, maxHeight: 50)
            } else {
                Text("Tischnummer \(order.tableNumber) (Bereit)")
                .frame(maxWidth: .infinity, maxHeight: 50)
            }
            if self.viewController.typesOfDishes.count == 0 {
                Rectangle().foregroundColor(Color(UIColor(hex: ColorValue.darkGray))).frame(width: 50, height: 50)
            } else if self.viewController.typesOfDishes.contains(DishesType.DRINKS) {
                Rectangle().foregroundColor(Color(UIColor(hex: ColorValue.userBar))).frame(width: 50, height: 50)
            } else {
                Rectangle().foregroundColor(Color(UIColor(hex: ColorValue.userKitchen))).frame(width: 50, height: 50)
            }
        }.frame(maxWidth: .infinity).border(Color(UIColor(hex: ColorValue.darkGray)), width: 4)
            .cornerRadius(8)
        .onReceive(self.viewController.$hasReadyDishes) { value in
            self.hasReadyDishes = value
        }
    }
}

struct ServiceActiveOrderAdapter_Previews: PreviewProvider {
    static var previews: some View {
        ServiceActiveOrdersAdapter(order: Order(companyReference: "", userReference: "", tableNumber: "T1", isActive: true, createdAt: "2020-02-11"), user: User(companyReference: "", name: "Grayner", password: "", role: .SERVICE), viewController: ServiceActiveOrdersAdapterViewController(order: Order(companyReference: "", userReference: "", tableNumber: "T1", isActive: true, createdAt: "2020-02-11")))
    }
}
