//
//  KitchenBarArchivedDishesView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct KitchenBarArchivedDishesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController: KitchenBarArchivedDishesViewController
    @State var user: User
    @State var order: Order
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(self.viewController.orderedDishes, id: \.self.orderedDish.documentId) { orderedDishHelper in
                        VStack {
                            HStack {
                                Text("\(orderedDishHelper.dish.name)")
                                    .padding(3)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .border(Color.gray)
                                    .shadow(color: .gray, radius: 5)
                            }.padding(.top, 10)
                        }
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
        }.frame(minWidth: 0, maxWidth: .infinity).padding(.horizontal, 10)
            .navigationBarTitle("Bestellungsdetails", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: self.user.role))
    }
}
