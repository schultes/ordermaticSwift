//
//  AdminDishesOverviewView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminDishesOverviewView: View {
    
    @Environment(\.presentationMode) var presentationMode
    let dishesType: DishesType
    
    @ObservedObject var viewController = AdminDishesOverviewViewController()
    @ObservedObject var editViewController = AdminDishEditViewController()
    
    @State private var createNewDishClicked = false
    
    init(dishesType: DishesType) {
        self.dishesType = dishesType
        viewController.getDishes(dishesType: dishesType)
    }
    
    var body: some View {
        ScrollView {
            ForEach(self.viewController.dishes, id: \.self.documentId) { dish in
                VStack {
                    AdminDishesEditAdapter(dish: dish, viewController: self.editViewController)
                }.frame(height: 100).padding(.horizontal, 10)
            }.padding(.horizontal, 20)
            
            HStack{
                Spacer()
                
                Button(action: {
                    self.createNewDishClicked = true
                }) {
                    VStack {
                        Image("icon_plus_black").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(10)
                    }
                    .background(Color(UIColor(hex: ColorValue.turquoise))).clipShape(Circle()).foregroundColor(Color.black)
                    .frame(alignment: .bottomTrailing)
                }.padding(.horizontal, 20).sheet(isPresented: self.$createNewDishClicked) {
                        LazyView {
                            NavigationView {
                                AdminDishEditView(viewController: self.editViewController, dishesType: self.dishesType, title: "", description: "", price: "")
                            }.navigationBarTitle("Neuer Eintrag", displayMode: .inline).navigationBarBackButtonHidden(true)
                        }
                }
            }.padding(.vertical, 10)
            
        }.navigationBarTitle("\(dishesType.rawValue) bearbeiten", displayMode: .inline).navigationBarBackButtonHidden(true).navigationBarItems(leading:
            getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .ADMIN)
        )
    }
}

struct AdminDishesOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDishesOverviewView(dishesType: .DESSERTS)
    }
}
