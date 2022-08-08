//
//  AdminDishesEditAdapter.swift
//  teamA
//
//  Created by FMA1 on 25.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminDishesEditAdapter: View {
    
    let dish: Dish
    @State private var editDishClicked = false
    @State var viewController: AdminDishEditViewController
    
    var body: some View {
        HStack(alignment: .top) {
            GeometryReader { g in
                HStack {
                    VStack {
                        Text("\(self.dish.name)")
                            .frame(minWidth: 0, maxWidth: g.size.width)
                            .padding(3)
                            .font(.system(size: 14))
                        
                        Divider()
                        
                        Text("\(self.dish.price)€")
                            .frame(minWidth: 0, maxWidth: g.size.width)
                            .padding(3)
                            
                            .font(.system(size: 14))
                        
                    }.frame(minWidth: 0, maxWidth: g.size.width*0.7, minHeight: 0, maxHeight: 80)
                
                
                    Button(action: {
                        self.editDishClicked = true
                    }) {
                        Text("Bearbeiten")
                    }
                    .frame(minWidth: 0, maxWidth: g.size.width*0.3, minHeight: 0, maxHeight: 80)
                    .padding(.horizontal,10)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
                    .background(Color(UIColor(hex: ColorValue.purple)))
                    .sheet(isPresented: self.$editDishClicked) {
                            LazyView {
                                NavigationView {
                                    AdminDishEditView(viewController: self.viewController, dish: self.dish, title: self.dish.name, description: self.dish.description, price: self.dish.price)
                                    .onDisappear() {
                                    self.editDishClicked = false
                                }.navigationBarTitle("Bearbeiten", displayMode: .inline).navigationBarBackButtonHidden(true)
                            }
                        }
                    }
                }
            }
        }.border(Color.gray, width: 4)
            .cornerRadius(10)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80)
    }
}
