//
//  ServiceOrderedDishesOverviewView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServiceOrderedDishesOverviewView: View {
    
    var user: User
    var order: Order
    
    @State var showAlert = false
    @State var showErrorMessage = false
    @State var saveSuccess = false
    @State var hasAlreadyOrderedDishes = false
    @State var viewController: ServiceOrderedDishesOverviewViewController = ServiceOrderedDishesOverviewViewController()
    @State var count = 0

    init(user: User, order: Order, dishes: [OrderedDish]) {
        self.user = user
        self.order = order
        self.viewController.setUnsavedOrderedDishes(dishes: dishes)
        self.viewController.setOrderedDishesListener(order: order)
    }
    
    var body: some View {
        VStack {
            Spacer()
                VStack {
                    Spacer()
                    NavigationLink(destination: LazyView {ServiceAddDishesToOrderView(user: self.user, order: self.order, dishesType: .DRINKS, alreadyOrderedDishes: self.viewController.unsavedOrderedDishes)}) {
                        getViewButton(imageName: "icon_dishes_drinks", title: "Getränke", color: UIColor(hex: ColorValue.adminEditDrinks))
                    }
                    Spacer()
                    NavigationLink(destination: LazyView {ServiceAddDishesToOrderView(user: self.user, order: self.order,dishesType: .STARTERS, alreadyOrderedDishes: self.viewController.unsavedOrderedDishes)}) {
                        getViewButton(imageName: "icon_dishes_starters", title: "Vorspeisen", color: UIColor(hex: ColorValue.adminEditStarters))
                    }
                    Spacer()
                    NavigationLink(destination: LazyView {ServiceAddDishesToOrderView(user: self.user, order: self.order,dishesType: .MAIN_DISHES, alreadyOrderedDishes: self.viewController.unsavedOrderedDishes)}) {
                        getViewButton(imageName: "icon_dishes_main_dishes", title: "Hauptspeisen", color: UIColor(hex: ColorValue.adminEditMainDishes))
                    }
                    Spacer()
                    NavigationLink(destination: LazyView {ServiceAddDishesToOrderView(user: self.user, order: self.order,dishesType: .DESSERTS, alreadyOrderedDishes: self.viewController.unsavedOrderedDishes)}) {
                        getViewButton(imageName: "icon_dishes_desserts", title: "Desserts", color: UIColor(hex: ColorValue.adminEditDesserts))
                    }
                    Spacer()
                }.padding(.horizontal, 30)
            Spacer()
            
            HStack {
                NavigationLink(destination: LazyView {ServiceAlreadyOrderedDishesView(order: self.order)}) {
                    getSmallViewButton(imageName: "icon_dishes_chosen", title: self.hasAlreadyOrderedDishes == true ?  "Bestellung *" : "Bestellung", color: UIColor(hex: ColorValue.serviceOrderedDishes))
                }
                
                Button(action: {
                    self.viewController.sendOrder()
                }) {
                    getSmallViewButton(imageName: "icon_send", title: "Senden", color: UIColor(hex: ColorValue.serviceSend))
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(self.showErrorMessage ? "Error" : "Erfolg"),
                        message: Text(self.showErrorMessage ? viewController.errorMessage : "Bestellung gesendet!"),
                        dismissButton: .default(Text("Ok"))
                    )
                }
                
                NavigationLink(destination: LazyView {ServicePaymentView(order: self.order, user: self.user)}) {
                    getSmallViewButton(imageName: "icon_pay", title: "Bezahlen", color: UIColor(hex: ColorValue.servicePayment))
                }
            }.padding(.vertical, 30)
            
            
        }.padding(.horizontal, 30).navigationBarTitle("Übersicht", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                HStack {
                NavigationLink(destination: LazyView {
                    ServiceDashboardView(user: self.user)
                }) {
                    HStack(spacing: 0) {
                        Image(systemName: "chevron.left").font(.title)
                    }
                }
                Image(ImageHelper.getLogoByUserRole(role: .SERVICE)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.leading, 20)
            })
        .onReceive(self.viewController.$showErrorMessage) { value in
            self.showErrorMessage = value
            if value == true {
                self.showAlert = true
            }
        }
        
        .onReceive(self.viewController.$saveSuccess) { value in
            self.saveSuccess = value
            if value == true {
                self.showAlert = true
            }
        }
        
        .onReceive(self.viewController.$hasAlreadyOrderedDishes) { value in
            self.hasAlreadyOrderedDishes = value
        }
    }
}

