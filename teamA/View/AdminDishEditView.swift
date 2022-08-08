//
//  AdminDishEditView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminDishEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var viewController: AdminDishEditViewController
    @State var dish: Dish? // Edit
    @State var dishesType: DishesType? // Add
    
    @State var title: String
    @State var description: String
    @State var price: String
    private let zIndex = 8.0
    

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("Titel")
            TextField("", text: $title)
            .padding(3)
            .font(.system(size: 14))
                .multilineTextAlignment(.leading)
            .border(Color(UIColor.lightGray), width: 1)
            .shadow(radius: 5)
            .zIndex(zIndex)
            
            
            Text("Beschreibung")
            TextView(text: $description).frame(numLines: 5)
            .multilineTextAlignment(.leading)
            .border(Color(UIColor.lightGray), width: 1)
            .shadow(radius: 5)
            .zIndex(zIndex)

            Text("Preis")
            HStack {
                TextField("", text: $price)
                    .padding(3)
                .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                .border(Color(UIColor.lightGray), width: 1)
                .shadow(radius: 5)
                .zIndex(zIndex)
                Text("€")
            }.padding(3)
            
            Button(action:{
                self.viewController.onSaveClicked(
                    dish: self.dish, dishesType: self.dishesType, title: self.title, description: self.description, price: self.price
                )
                
            }) {
                Text("Speichern")
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 30)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
                .background(Color(UIColor(hex: ColorValue.purple)))
                .cornerRadius(10)
                .padding(.horizontal, 40)
            }.padding(.top, 50)
            
            if dish != nil {
                Button(action: { self.viewController.onDeleteClicked(dish: self.dish) }) {
                Text("Löschen")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 30)
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
                    .background(Color(UIColor(hex: ColorValue.purple)))
                    .cornerRadius(10)
                    .padding(.horizontal, 60)
                }
            }
            
            Spacer()
        }
        .onReceive(self.viewController.$succeed) {
            succeed in
            if succeed {
                self.viewController.succeed = false
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(10)
        .navigationBarTitle(dishesType == nil ? "Bearbeiten" :"Neuer Eintrag", displayMode: .inline).navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Fertig")
        })
    }

}
