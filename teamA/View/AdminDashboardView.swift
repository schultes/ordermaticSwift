//
//  ContentView.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminDashboardView: View {
    
    @State var isUserLoggedIn = true

    var body: some View {
        Group {
            if isUserLoggedIn {
                ScrollView {
                    VStack {
                        
                        Spacer()
                        
                        NavigationLink(destination: LazyView {AdminUsersOverviewView()}) {
                            getViewButton(imageName: "icon_person", title: "Personen", color: UIColor(hex: ColorValue.adminEditUser), horizontalPadding: 50)
                        }
                        
                        NavigationLink(destination: LazyView {AdminDishesOverviewView(dishesType: .DRINKS)}) {
                            getViewButton(imageName: "icon_dishes_drinks", title: "Getränke", color: UIColor(hex: ColorValue.adminEditDrinks), horizontalPadding: 50)
                        }
                        
                        NavigationLink(destination: LazyView {AdminDishesOverviewView(dishesType: .STARTERS)}) {
                            getViewButton(imageName: "icon_dishes_starters", title: "Vorspeisen", color: UIColor(hex: ColorValue.adminEditStarters), horizontalPadding: 50)
                        }
                        
                        NavigationLink(destination: LazyView {AdminDishesOverviewView(dishesType: .MAIN_DISHES)}) {
                            getViewButton(imageName: "icon_dishes_main_dishes", title: "Hauptspeisen", color: UIColor(hex: ColorValue.adminEditMainDishes), horizontalPadding: 50)
                        }
                        
                        NavigationLink(destination: LazyView {AdminDishesOverviewView(dishesType: .DESSERTS)}) {
                            getViewButton(imageName: "icon_dishes_desserts", title: "Desserts", color: UIColor(hex: ColorValue.adminEditDesserts), horizontalPadding: 50)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: LazyView {GeneralMenuSelectionView()}) {
                            getViewButton(imageName: "icon_menu", title: "Speisekarte anzeigen", color: UIColor(hex: ColorValue.generalMenu), horizontalPadding: 20).padding(.top, 50)
                        }
                        
                        Button(action: {self.isUserLoggedIn = false}) {
                            Text("Logout")
                                .frame(minWidth: 80, maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold))
                                .background(Color(UIColor(hex: ColorValue.rosa)))
                                .cornerRadius(10)
                        }.padding(.horizontal, 20)
                        
                        
                    }.padding(.horizontal, 10)
                        .padding(.top, 10).padding(.bottom, 30)
                }.navigationBarTitle("Bearbeiten", displayMode: .inline).navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Image(ImageHelper.getLogoByUserRole(role: .ADMIN)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading))
            } else {
                GeneralChooseAccountView()
            }
        }
    }
}



struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView()
    }
}
