//
//  GeneralChooseAccountView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralChooseAccountView: View {
    
    @ObservedObject var viewController = GeneralChooseAccountViewController()
    
    var body: some View {
        Group {
            if viewController.isSignedIn {
                GeometryReader { gr in
                    ScrollView {
                        VStack {
                            VStack {
                                Image("logo_complete").scaledToFit().padding(.horizontal, 20)
                                
                                Text(self.viewController.companyName).padding(.bottom, 10)
                                VStack {
                                    ForEach(self.viewController.users, id: \.self.documentId) { user in
                                        NavigationLink(destination: LazyView { GeneralUserLoginView(user: user) }) {
                                            GeneralChooseAccountAdapter(user: user)
                                        }
                                    }.padding(.horizontal, 20)
                                }.frame(minWidth: 0, minHeight: gr.size.height*0.45, alignment: .top)
                                Spacer()
                                Button(action: self.viewController.onLogoutClicked) {
                                    Text("LOGOUT")
                                        .frame(minWidth: 80, maxWidth: 80, alignment: .bottom)
                                        .frame(height: 40)
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .bold))
                                        .background(Color(UIColor(hex: ColorValue.purple)))
                                        .cornerRadius(10)
                                }.padding(.bottom, 10)
                            }
                        }
                    }
                }.navigationBarTitle("").navigationBarHidden(true)
            } else {
                AuthenticationBusinessLoginView()
            }
        }
    }
}

struct GeneralChooseAccountView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralChooseAccountView()
    }
}
