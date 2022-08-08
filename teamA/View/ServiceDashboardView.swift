//
//  ServiceDashboardView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServiceDashboardView: View {
    
    @ObservedObject var viewController = ServiceDashboardViewController()
    
    @ObservedObject var serviceCreateOrderViewController = ServiceCreateOrderViewController()
    
    @State var isUserLoggedIn = true
    var user: User
    
    var body: some View {
        Group {
            if isUserLoggedIn {
                GeometryReader { gr in
                    ScrollView {
                        VStack {
                            
                            NavigationLink(destination: LazyView {ServiceCreateOrderView(viewController: self.serviceCreateOrderViewController, user: self.user)}) {
                                Text("Bedienung starten").foregroundColor(.white).font(.system(size: 25, weight: .bold)).multilineTextAlignment(.center)
                            }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 90).background(Color(UIColor(hex: ColorValue.turquoise))).cornerRadius(15).padding(.horizontal, 100)
                            Text("Aktive Bestellungen").font(.system(size: 20, weight: .bold)).padding(.top, 20)
                            
                            VStack {
                                ForEach(self.viewController.activeOrders, id: \.self.documentId) { order in
                                    NavigationLink(destination: LazyView {ServiceOrderedDishesOverviewView(user: self.user, order: order, dishes: [OrderedDish]())}) {
                                        VStack {
                                            ServiceActiveOrdersAdapter(order: order, user: self.user, viewController: ServiceActiveOrdersAdapterViewController(order: order))
                                        }.frame(height: 50).padding(.horizontal, 10)
                                    }.padding(.horizontal, 20).foregroundColor(Color.black)
                                }
                            }.frame(minHeight: gr.size.height*0.4, alignment: .top)
                            
                            VStack {
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
                            }
                            
                        }.padding(.horizontal, 10)
                            .padding(.top, 10).padding(.bottom, 10)
                    }
                    .navigationBarTitle("\(self.user.role.rawValue)-Home", displayMode: .inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Image(ImageHelper.getLogoByUserRole(role: .SERVICE)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading))
                    .frame(minHeight: gr.size.height)
                }
            } else {
                GeneralChooseAccountView()
            }
            
        }
    }
}

struct ServiceDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDashboardView(user: User(companyReference: "", name: "User", password: "", role: .SERVICE))
    }
}
