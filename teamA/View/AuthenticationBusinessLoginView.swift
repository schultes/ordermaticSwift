//
//  AuthenticationBusinessLoginView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI
import Combine

struct AuthenticationBusinessLoginView: View {
    @ObservedObject var viewController = AuthenticationBusinessLoginViewController()
    
    @State var email: String = ""
    @State var password: String = ""
    private let zIndex = 8.0
    
    var body: some View {
        
        Group {
            if !viewController.isSignedIn {
                ScrollView {
                    
                    Image("logo_complete").scaledToFit().padding(.horizontal, 20).padding(.top, 30)
                    
                    Spacer(minLength: 40)
                    
                    TextField("Email des Betriebs", text: $email)
                        .font(.system(size: 14))
                        .padding(12)
                        .multilineTextAlignment(.center)
                        .textContentType(.emailAddress)
                        .border(Color(UIColor.lightGray), width: 1)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                        .cornerRadius(10)
                        .zIndex(zIndex)
                    
                    SecureField("Passwort", text: $password)
                        .font(.system(size: 14))
                        .padding(12)
                        .multilineTextAlignment(.center)
                        .border(Color(UIColor.lightGray), width: 1)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                        .cornerRadius(10)
                        .zIndex(zIndex)
                    
                    Spacer(minLength: 50)
                    
                    Button(action: { self.viewController.onLoginClicked(email: self.email, password: self.password) }) {
                        Text("Anmelden")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 50).alert(isPresented: $viewController.showError) {
                        Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))
                    }
                    
                    NavigationLink(destination: AuthenticationBusinessRegisterView()) {
                        Text("Registrieren")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .bold))
                            .background(Color.white)
                    }.isDetailLink(false).padding(.horizontal, 20)
                    
                    
                }.modifier(Keyboard()).navigationBarTitle("").navigationBarHidden(true)
            } else {
                GeneralChooseAccountView()
            }
        }
    }
    
}

struct AuthenticationBusinessLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationBusinessLoginView()
    }
}
