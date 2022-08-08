//
//  KitchenBarDashboardView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct KitchenBarDashboardView: View {
    
    @State var isUserLoggedIn = true
    var user: User
    
    var body: some View {
        Group {
            if isUserLoggedIn {
                VStack {
                    
                    NavigationLink(destination: LazyView {KitchenBarActiveOrdersView(user: self.user)}) {
                        getViewButton(imageName: "icon_order_current", title: "Aktuelle\nBestellungen", color: UIColor(hex: ColorValue.turquoise), horizontalPadding: 50).multilineTextAlignment(.center)
                    }
                    
                    NavigationLink(destination: LazyView {KitchenBarArchivedOrdersView(user: self.user)}) {
                        getViewButton(imageName: "icon_order_completed", title: "Abgeschlossene\nBestellungen", color: UIColor(hex: ColorValue.generalMenu), horizontalPadding: 50).multilineTextAlignment(.center)
                    }
                                        
                    Spacer()
                    
                    Button(action: {self.isUserLoggedIn = false}) {
                        Text("Logout")
                            .frame(minWidth: 80, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 25, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.rosa)))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    .navigationBarTitle("\(self.user.role.rawValue)-Home", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Image(ImageHelper.getLogoByUserRole(role: self.user.role)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading))
                }.padding(.vertical, 20)
            } else {
                GeneralChooseAccountView()
            }
        }
    }
}

struct KitchenBarDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenBarDashboardView(user: User(companyReference: "", name: "User", password: "", role: .KITCHEN))
    }
}
