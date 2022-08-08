//
//  ServiceAddDishesToOrderView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI
import Combine

struct ServiceAddDishesToOrderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var user: User
    var order: Order
    var dishesType: DishesType
    var alreadyOrderedDishes: [OrderedDish] // unsaved and original
    
    @State var comment = ""
    @State var newOrderedDishes = [OrderedDish]()
    @State var shouldTransit = false
    
    @State var keyboardHeight: CGFloat = 0
    
    @ObservedObject var viewController = ServiceAddDishesToOrderViewController()
    
    init(user: User, order: Order, dishesType: DishesType, alreadyOrderedDishes: [OrderedDish]) {
        self.user = user
        self.order = order
        self.dishesType = dishesType
        self.alreadyOrderedDishes = alreadyOrderedDishes
        self.viewController.getDishesList(dishesType: dishesType)
    }
    
    var body: some View {
        Group {
            if !shouldTransit {
                VStack {
                    GeometryReader { gr in
                        ScrollView {
                            
                            VStack(alignment: .center, spacing: 0) {
                                ForEach(self.viewController.dishesList, id: \.self.documentId) { dish in
                                    VStack {
                                        HStack(alignment: .center) {
                                            Text(
                                                "\(dish.name)" +
                                                    (self.newOrderedDishes.filter { $0.dishReference == dish.documentId}.count > 0 ? "(\(self.newOrderedDishes.filter { $0.dishReference == dish.documentId}.count))x": "")
                                            ).frame(minWidth: 20, maxWidth: .infinity)
                                            Spacer()
                                            Button(action: {
                                                self.newOrderedDishes.append(OrderedDish(companyReference: self.order.companyReference, userReference: self.order.userReference, orderReference: self.order.documentId!, dishReference: dish.documentId!, status: OrderDishesStatus.UNDONE, comment: ""))
                                            }) {
                                                getServiceViewButton(imageName: "icon_plus_black", color: UIColor(hex: ColorValue.turquoise))
                                            }
                                            
                                            Button(action: {
                                                if let index = self.newOrderedDishes.firstIndex(where: {$0.dishReference == dish.documentId!}) {
                                                    self.newOrderedDishes.remove(at: index)
                                                }
                                            }) {
                                                getServiceViewButton(imageName: "icon_minus", color: UIColor(hex: ColorValue.redLight))
                                            }
                                            
                                        }.frame(minHeight: 10, alignment: .top)
                                        Divider().padding(.bottom, 10)
                                    }
                                }
                                
                            }.padding(.top, 10).frame(minWidth: 0, minHeight: gr.size.height*0.60, alignment: .top)
                            
                            Spacer()
                            VStack {
                                Text("Kommentar")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                TextField("", text: self.$comment)
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.leading)
                                    .border(Color(UIColor.lightGray), width: 1)
                                    .shadow(radius: 5)
                                
                                Button(action: {
                                    var list = self.alreadyOrderedDishes
                                    for d in self.newOrderedDishes {
                                        var temp = d
                                        temp.comment = self.comment
                                        list.append(temp)
                                    }
                                    self.newOrderedDishes = list
                                    self.shouldTransit = true
                                }) {
                                    Text("Bestätigen")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 40)
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .bold))
                                        .background(Color(UIColor(hex: ColorValue.purple)))
                                        .cornerRadius(10)
                                }.padding(.top, 20)
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: gr.size.height)
                    }
                    
                }.padding(.horizontal, 20).navigationBarTitle("Hinzufügen", displayMode: .inline).navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                        getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .SERVICE)
                )
                    .padding(.bottom, keyboardHeight + 20).padding(.top, 20)
                    .onReceive(Publishers.keyboardHeight) {
                        self.keyboardHeight = $0
                }
            } else {
                LazyView {
                    ServiceOrderedDishesOverviewView(user: self.user, order: self.order, dishes: self.newOrderedDishes)
                }
                
            }
        }
    }
}

