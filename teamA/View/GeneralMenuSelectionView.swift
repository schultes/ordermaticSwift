//
//  GeneralMenuSelectionView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralMenuSelectionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = GeneralMenuDishesViewController()

    var body: some View {

            VStack {
                
                Spacer()
                
                NavigationLink(destination: LazyView {GeneralMenuDishesView(dishesType: .DRINKS)}) {
                    getViewButton(imageName: "icon_dishes_drinks", title: "Getränke", color: UIColor(hex: ColorValue.adminEditDrinks))
                }
                Spacer()
                NavigationLink(destination: LazyView {GeneralMenuDishesView(dishesType: .STARTERS)}) {
                    getViewButton(imageName: "icon_dishes_starters", title: "Vorspeisen", color: UIColor(hex: ColorValue.adminEditStarters))
                }
                Spacer()
                NavigationLink(destination: LazyView {GeneralMenuDishesView(dishesType: .MAIN_DISHES)}) {
                    getViewButton(imageName: "icon_dishes_main_dishes", title: "Hauptspeisen", color: UIColor(hex: ColorValue.adminEditMainDishes))
                }
                Spacer()
                NavigationLink(destination: LazyView {GeneralMenuDishesView(dishesType: .DESSERTS)}) {
                    getViewButton(imageName: "icon_dishes_desserts", title: "Desserts", color: UIColor(hex: ColorValue.adminEditDesserts))
                }
                Spacer()
                
            }.padding(.horizontal, 40)
        .navigationBarTitle("Übersicht", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: nil)
            )
    }

  }

struct GeneralMenuSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralMenuSelectionView()
    }
}
