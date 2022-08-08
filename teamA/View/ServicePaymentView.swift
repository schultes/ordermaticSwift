//
//  ServicePaymentView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServicePaymentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = ServicePaymentViewController()
    var order: Order
    var user: User
    
    init(order: Order, user: User) {
        self.order = order
        self.user = user
        viewController.getOrderedDishes(order: order)
    }
    
    var body: some View {
        Group {
            if !viewController.paymentSuccess {
                VStack {
                    ScrollView {
                        VStack {
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
                            Text("Gesamt: \(String(format: "%.2f", self.viewController.bill)) €").padding(.top, 30).padding(.bottom, 20).font(.system(size: 20))
                            
                            Button(action: {
                                self.viewController.payOrder(order: self.order)
                            }) {
                                getViewButton(imageName: "icon_pay_card", title: "EC-Karte", color: UIColor(hex: ColorValue.servicePaymentCard)).padding(.horizontal, 60)
                            }
                            Button(action: {
                                self.viewController.payOrder(order: self.order)
                            }) {
                                getViewButton(imageName: "icon_pay_cash", title: "Bargeld", color: UIColor(hex: ColorValue.servicePaymentCash)).padding(.horizontal, 60)
                            }
                            
                        }.frame(minWidth: 0, maxWidth: .infinity).padding(.top, 20)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }.frame(minWidth: 0, maxWidth: .infinity).padding(.horizontal, 10)
                    .alert(isPresented: $viewController.showErrorMessage) {
                Alert(title: Text("Error"), message: Text("Ein Fehler ist aufgetreten!"), dismissButton: .default(Text("Ok")))}
                    .navigationBarTitle("\(order.tableNumber): Check", displayMode: .inline).navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                        getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .SERVICE))
            } else {
                LazyView {
                    ServiceDashboardView(user: self.user)
                }
            }
        }
    }
}
