//
//  AdminUserEditView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminUserEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var viewController: AdminUserEditViewController
    @State var user: User
    
    @State var oldPassword = ""
    @State var newPassword = ""
    @State var newPasswordRepeat = ""
    var zIndex = 8.0
    
    @State var colorKitchen: String
    @State var colorBar: String
    @State var colorService: String
    
    var body: some View {
        Group {
            NavigationView {
                VStack {
                    Group {
                        
                        Text("Altes Password eingeben:").padding(.top, 20)
                        TextField("", text: $oldPassword)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).textContentType(.addressState).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        
                        Spacer()
                        Text("Neues Passwort eingeben:")
                        SecureField("", text: $newPassword)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5).padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                        
                        Spacer()
                        Text("Passwort bestätigen:")
                        SecureField("", text: $newPasswordRepeat)
                            .font(.system(size: 14)).padding(12).multilineTextAlignment(.center).border(Color(UIColor.lightGray), width: 1).shadow(radius: 5)
                            .padding(.horizontal, 20).cornerRadius(10).zIndex(zIndex)
                    }
                    Spacer()
                    Text("Rolle auswählen:").padding(.bottom, 5)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.viewController.onUserRoleClicked(role: .KITCHEN)
                            self.onUserRoleClicked(role: .KITCHEN)
                        }) {
                            VStack {
                                Image("icon_kitchen").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.KITCHEN.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.colorKitchen)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            self.viewController.onUserRoleClicked(role: .SERVICE)
                            self.onUserRoleClicked(role: .SERVICE)
                        }) {
                            VStack {
                                Image("icon_service").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.SERVICE.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.colorService)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {
                            self.viewController.onUserRoleClicked(role: .BAR)
                            self.onUserRoleClicked(role: .BAR)
                        }) {
                            VStack {
                                Image("icon_bar").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.top, 10)
                                Text(UserRole.BAR.rawValue)
                                    .padding(5)
                                    .font(.system(size: 15, weight: .bold))
                                    .frame(width: 80)
                                    .padding(.bottom, 10)
                            }.background(Color(UIColor(hex: self.colorBar)))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        
                    }.alert(isPresented: $viewController.showError) {
                        Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))}
                    
                    Spacer()
                    Button(action: { self.viewController.onSaveClicked(oldUser: self.user, passwordOld: self.oldPassword, passwordNew: self.newPassword, passwordNewRepeat: self.newPasswordRepeat) }) {
                        Text("Änderungen bestätigen")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 20).padding(.bottom, 10)
                    
                    Button(action: {
                        self.viewController.onDeleteClicked(oldUser: self.user)
                    }) {
                        VStack {
                            Image("icon_person_delete").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(10)
                        }
                        .background(Color(UIColor(hex: ColorValue.redLight))).clipShape(Circle()).foregroundColor(Color.black)
                        .frame(alignment: .bottomTrailing)
                    }.padding(.horizontal, 20)
                    
                    
                    Spacer()
                    
                }
                    
                .onReceive(self.viewController.$succeed) { succeed in
                    if succeed {
                        self.viewController.succeed = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }.padding(.top, -100).navigationBarTitle("Profil bearbeiten (\(user.name))", displayMode: .inline).navigationBarBackButtonHidden(true).navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Fertig")
        })
    }
    
    func onUserRoleClicked(role: UserRole) {
        switch role {
        case .KITCHEN:
            colorKitchen = ColorValue.userKitchenSelected
            colorBar = ColorValue.userBar
            colorService = ColorValue.userService
        case .BAR:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBarSelected
            colorService = ColorValue.userService
        case .SERVICE:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBar
            colorService = ColorValue.userServiceSelected
        case .ADMIN:
            colorKitchen = ColorValue.userKitchen
            colorBar = ColorValue.userBar
            colorService = ColorValue.userService
        }
    }
    
}



