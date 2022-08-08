//
//  ServiceAlreadyOrderedDishesView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServiceAlreadyOrderedDishesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = ServiceAlreadyOrderedDishesViewController()
    var order: Order
    
    init(order: Order) {
        self.order = order
        viewController.getOrderedDishes(order: order)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Was wurde bestellt?").font(.system(size: 24, weight: .bold)).padding(.bottom, 30).padding(.top, 10)
                    ForEach(self.viewController.orderedDishes, id: \.self.orderedDish.documentId) { orderedDishHelper in
                        VStack {
                            HStack {
                                Text("\(orderedDishHelper.dish.name)").frame(maxWidth: .infinity)
                                    .foregroundColor(Color(UIColor(
                                        hex: orderedDishHelper.orderedDish.status == .DONE ? ColorValue.serviceDone :
                                            (orderedDishHelper.orderedDish.status == .READY ? ColorValue.serviceReady : ColorValue.serviceUndone)
                                    )))
                                Spacer()
                                Text("\(orderedDishHelper.dish.price) €").frame(minWidth: 0, alignment: .trailing)
                            }.onTapGesture() {
                                if orderedDishHelper.orderedDish.status == .READY {
                                    self.viewController.setOrderedDishesStatus(orderedDish: orderedDishHelper.orderedDish, dishesStatus: .DONE)
                                }
                            }
                            Divider()
                        }.frame(maxWidth: .infinity)
                    }
                    Text("Gesamt: \(String(format: "%.2f", self.viewController.bill)) €").padding(.top, 30).padding(.bottom, 20)
                }.frame(minWidth: 0, maxWidth: .infinity)
            }.frame(minWidth: 0, maxWidth: .infinity)
        }.frame(minWidth: 0, maxWidth: .infinity).padding(.horizontal, 10)
            
            .navigationBarTitle("Bestellungen", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .SERVICE))
    }
}
