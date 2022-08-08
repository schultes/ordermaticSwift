//
//  KitchenBarArchivedOrdersView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct KitchenBarArchivedOrdersView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = KitchenBarArchivedOrdersViewController()
    @ObservedObject var viewControllerForDishes = KitchenBarArchivedDishesViewController()
    var user: User
    
    init(user: User) {
        self.user = user
        viewController.getArchivedOrders(user: user)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(self.viewController.archivedOrders, id: \.self.documentId) { order in
                        
                        HStack {
                            
                            NavigationLink(destination: LazyView { KitchenBarArchivedDishesView(viewController: self.viewControllerForDishes, user: self.user, order: order)
                                .onAppear() {
                                    self.viewController.setIsViewActive(value: false)
                                    self.viewControllerForDishes.getDishes(order: order, user: self.user)
                            }
                            .onDisappear() {
                                self.viewController.setIsViewActive(value: true)
                                self.viewController.getArchivedOrders(user: self.user)
                                }
                                
                            }) {
                                Text("Tischnummer: \(order.tableNumber)")
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .foregroundColor(.white)
                                    .background(Color(UIColor(hex: ColorValue.purple)))
                                    .font(.system(size: 16, weight: .bold))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 10)
                            }
                        }.padding(.top, 10)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)    
            }
        }.frame(minWidth: 0, maxWidth: .infinity).padding(.horizontal, 20)
            .navigationBarTitle("\(self.user.role.rawValue)-Bestellungsarchiv", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: self.user.role))
    }
}

struct KitchenBarArchivedOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenBarArchivedOrdersView(user: User(companyReference: "", name: "", password: "", role: .BAR))
    }
}
