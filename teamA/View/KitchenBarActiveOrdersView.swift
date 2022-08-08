//
//  KitchenBarActiveOrdersView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct KitchenBarActiveOrdersView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = KitchenBarActiveOrdersViewController()
    @ObservedObject var viewControllerForDishes = KitchenBarActiveDishesViewController()
    var user: User
    
    init(user: User) {
        self.user = user
        viewController.getActiveOrders(user: user)
    }
    
    var body: some View {
        VStack {
            GeometryReader { gr in
                ScrollView {
                    VStack {
                        ForEach(self.viewController.matchedOrders, id: \.self.documentId) { order in
                            VStack {
                                HStack {
                                    
                                    NavigationLink(destination: LazyView { KitchenBarActiveDishesView(viewController: self.viewControllerForDishes, user: self.user, order: order).onAppear() {
                                        self.viewController.setIsViewActive(value: false)
                                        self.viewControllerForDishes.getActiveDishes(order: order, user: self.user)
                                    }.onDisappear() {
                                        self.viewController.setIsViewActive(value: true)
                                        self.viewController.getActiveOrders(user: self.user)
                                        }}) {
                                        Text("Tischnummer: \(order.tableNumber)\n\(order.createdAt.formatDate())").frame(maxWidth: .infinity, minHeight: 60).multilineTextAlignment(.center)
                                            .foregroundColor(.white).background(Color(UIColor(hex: ColorValue.purple))).font(.system(size: 16, weight: .bold)).cornerRadius(10).padding(.horizontal, 10)
                                    }

                                    Button(action: {
                                        if self.viewController.isOrderChecked(order: order) { self.viewController.removeOrderFromChangedOrders(order: order)
                                        } else { self.viewController.addOrderToChangedOrders(order: order) }
                                    }) {
                                        HStack {
                                            Image(systemName: self.viewController.isOrderChecked(order: order) ? "checkmark.square": "square")
                                            Text("auswählen").font(.system(size: 12))
                                        }.foregroundColor(.black)
                                    }
                                }
                                Divider()
                            }.frame(maxWidth: .infinity).padding(.top, 20)
                        }
                        
                    }.frame(minWidth: 0, minHeight: gr.size.height*0.85, alignment: .top)
                    Button(action: {
                        self.viewController.sendStatusOfOrders(user: self.user)
                    }) {
                        Text("Senden")
                            .frame(minWidth: 80, maxWidth: .infinity)
                            .frame(height: 60)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 20)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: gr.size.height)
            }
        }.frame(minWidth: 0, maxWidth: .infinity).padding(.horizontal, 10)
            
            .navigationBarTitle("Bestellungen", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: self.user.role)
        )
    }
}

struct KitchenBarActiveOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenBarActiveOrdersView(user: User(companyReference: "", name: "", password: "", role: .BAR))
    }
}
