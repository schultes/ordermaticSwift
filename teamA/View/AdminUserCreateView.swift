//
//  AdminUserCreateView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminUserCreateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = AdminUserCreateViewController()
    
    @State var name = "Tom"
    @State var password = "Test1234#"
    @State var passwordRepeat = "Test1234#"
    var zIndex = 8.0
    
    var body: some View {
        Group {
            NavigationView {
                VStack {
                    Group {
                        
                        Text("Name eingeben:")
                        TextField("Max Mustermann", text: $name)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.addressState).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        
                        Spacer()
                        Text("Neues Passwort eingeben:")
                        SecureField("Passwort", text: $password)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        
                        Spacer()
                        Text("Passwort bestätigen:")
                        SecureField("Passwort bestätigen", text: $passwordRepeat)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5)
                            .padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    }
                    Spacer()
                    Text("Rolle auswählen:").padding(.bottom, 5)
                    HStack {
                        Spacer()
                        Button(action: { self.viewController.onUserRoleClicked(role: .KITCHEN) }) {
                            VStack {
                                Image("icon_kitchen").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.KITCHEN.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.viewController.colorKitchen)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: { self.viewController.onUserRoleClicked(role: .SERVICE) }) {
                            VStack {
                                Image("icon_service").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.SERVICE.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.viewController.colorService)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: { self.viewController.onUserRoleClicked(role: .BAR) }) {
                            VStack {
                                Image("icon_bar").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.BAR.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.viewController.colorBar)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        
                    }.alert(isPresented: $viewController.showError) {
                        Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))}
                    
                    Spacer()
                    Button(action: { self.viewController.onSaveClicked(name: self.name, password: self.password, passwordRepeat: self.passwordRepeat) }) {
                        Text("Änderungen bestätigen")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 20)
                    Spacer()
                    
                }
                    
                .onReceive(self.viewController.$createSucceed) { succeed in
                    if succeed {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }.navigationBarTitle("Profil anlegen", displayMode: .inline).navigationBarBackButtonHidden(true)
        }.padding(.top, -100)
    }
    
    
}


struct AdminUserCreateView_Previews: PreviewProvider {
    static var previews: some View {
        AdminUserCreateView()
    }
}
