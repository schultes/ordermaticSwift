//
//  KitchenBarActiveDishesView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct KitchenBarActiveDishesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController: KitchenBarActiveDishesViewController
    @State var user: User
    @State var order: Order
    
    var body: some View {
        VStack {
            GeometryReader { gr in
                ScrollView {
                    VStack {
                        ForEach(self.viewController.matchedOrderedDishes, id: \.self.orderedDish.documentId) { orderedDishHelper in
                            VStack {
                                HStack {
                                    Text("\(orderedDishHelper.dish.name)")
                                        .padding(3)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                                        .border(Color.gray)
                                        .shadow(color: .gray, radius: 5)
                                        .multilineTextAlignment(.leading)
                                    Button(action: {
                                        if self.viewController.isOrderChecked(order: orderedDishHelper) { self.viewController.removeOrderedDishFromChangedOrders(order: orderedDishHelper)
                                        } else { self.viewController.addOrderedDishToChangedOrders(order: orderedDishHelper) }
                                    }) {
                                        HStack {
                                            Image(systemName: self.viewController.isOrderChecked(order: orderedDishHelper) ? "checkmark.square": "square")
                                            Text("Auswählen").font(.system(size: 12))
                                        }.foregroundColor(.black)
                                    }
                                }
                                Divider()
                            }.frame(maxWidth: .infinity).padding(.top, 20)
                        }
                        
                    }.frame(minWidth: 0, minHeight: gr.size.height*0.80, alignment: .top)
                    Text("\(self.viewController.comment)").padding(.bottom, 5).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 20)
                    Button(action: {
                        self.viewController.sendStatusOfOrderedDishes(order: self.order)
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
