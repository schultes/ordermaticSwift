//
//  AuthenticationBusinessRegisterView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AuthenticationBusinessRegisterView: View {
    
    @ObservedObject var viewController = AuthenticationBusinessRegisterViewController()
    private let zIndex = 8.0
    
    @State var companyName: String = ""
    @State var companyAdressFirstLine: String = ""
    @State var companyAdressSecondLine: String = ""
    @State var companyPassword: String = ""
    @State var companyPasswordRepeat: String = ""
    
    @State var adminName: String = ""
    @State var adminEmail: String = ""
    @State var adminPassword: String = ""
    @State var adminPasswordRepeat: String = ""
    
    var body: some View {
        Group {
            if !viewController.isSignedIn {
                ScrollView {
                    Image("logo_complete").scaledToFit().padding(.horizontal, 20).padding(.top, -60)
                    Spacer(minLength: 40)
                    Group {
                        TextField("Name des Betriebs", text: $companyName)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.name).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        TextField("Adresszeile 1", text: $companyAdressFirstLine)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.addressCity).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        TextField("Adresszeile 2", text: $companyAdressSecondLine)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.addressState).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        SecureField("Passwort", text: $companyPassword)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        SecureField("Passwort bestätigen", text: $companyPasswordRepeat)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5)
                            .padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    }
                    Spacer(minLength: 50)
                    TextField("Name des Inhabers", text: $adminName)
                        .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.name)
                        .border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    TextField("E-Mail Adresse", text: $adminEmail)
                        .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.emailAddress)
                        .border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    SecureField("Admin-Passwort", text: $adminPassword)
                        .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5)
                        .padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    SecureField("Admin-Passwort bestätigen", text: $adminPasswordRepeat)
                        .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1)
                        .shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    Spacer(minLength: 50)
                    Button(action: {
                        self.viewController.onRegisterClicked(
                            companyName: self.companyName,
                            companyAdressFirstLine: self.companyAdressFirstLine,
                            companyAdressSecondLine: self.companyAdressSecondLine,
                            companyPassword: self.companyPassword,
                            companyPasswordRepeat: self.companyPasswordRepeat,
                            adminName: self.adminName,
                            adminEmail: self.adminEmail,
                            adminPassword: self.adminPassword,
                            adminPasswordRepeat: self.adminPasswordRepeat
                        )
                    }) {
                        Text("Registrieren")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 50).padding(.bottom, 50)
                        .alert(isPresented: $viewController.showError) {
                            Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))
                    }
                }.modifier(Keyboard())
                
            } else {
                GeneralChooseAccountView()
            }
        }
    }
}



struct AuthenticationBusinessRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationBusinessRegisterView()
    }
}
