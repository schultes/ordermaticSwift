//
//  ServiceCreateOrderView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct ServiceCreateOrderView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController: ServiceCreateOrderViewController
    var user: User
    @State var tableNumber = ""
    
    init(viewController: ServiceCreateOrderViewController, user: User) {
        self.viewController = viewController
        self.user = user
    }
    
    var body: some View {
        Group {
            if !self.viewController.createSucceed {
                VStack(alignment: .leading) {
                    
                    Text("Tisch Bezeichnung")
                    TextField("", text: $tableNumber).font(.system(size: 14))
                    .padding(12)
                    .multilineTextAlignment(.leading)
                    .textContentType(.emailAddress)
                    .border(Color(UIColor.lightGray), width: 1)
                    .shadow(radius: 5)
                    
                    Button(action: { self.viewController.onCreateNewOrderClicked(tableNumber: self.tableNumber, user: self.user) }) {
                        Text("Erstellen")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 50).padding(.top, 20)
                        .alert(isPresented: $viewController.showErrorMessage) {
                            Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))}
                    Spacer()
                }.navigationBarTitle("Neuer Tisch", displayMode: .inline).navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                        getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .SERVICE))
                    .padding(.horizontal, 20).padding(.top, 20)
            } else {
                LazyView {
                    ServiceOrderedDishesOverviewView(user: self.user, order: self.viewController.order!, dishes: [OrderedDish]())
                }
            }
        }
    }
}

