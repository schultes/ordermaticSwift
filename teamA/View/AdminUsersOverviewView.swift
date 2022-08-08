//
//  AdminUsersOverviewView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct AdminUsersOverviewView: View {
    @ObservedObject var viewController = AdminUsersOverviewViewController()
    @ObservedObject var userEditViewController = AdminUserEditViewController()
    @Environment(\.presentationMode) var presentationMode
    @State private var createNewUserClicked = false
    @State private var editUserClicked = false
    
    @State private var selectedUser: User? = nil
    @State var colorKitchen = ColorValue.userKitchen
    @State var colorBar = ColorValue.userBar
    @State var colorService = ColorValue.userService
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack {
                        ForEach(self.viewController.users, id: \.self.documentId) { user in
                            
                            Button(action: {
                                self.selectedUser = user
                                self.userEditViewController.onUserRoleClicked(role: user.role)
                                self.setColors(role: user.role)
                                self.editUserClicked = true
                            }) {
                                VStack {
                                    Text("\(user.name)").frame(maxWidth: .infinity, alignment: .center).font(.system(size: 22)).padding(20).background(Color(UIColor(hex: ColorValue.purple))).foregroundColor(.white)
                                    
                                }.frame(
                                    maxWidth: .infinity,
                                    alignment: .topLeading
                                )
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                            }
                        }
                    }.frame(alignment: .topLeading).padding(5)
                        .sheet(isPresented: self.$editUserClicked) {
                            LazyView {
                                NavigationView {
                                    AdminUserEditView(viewController: self.userEditViewController, user: self.selectedUser!, colorKitchen: self.colorKitchen, colorBar: self.colorBar, colorService: self.colorService)
                                }.navigationBarTitle("Profil bearbeiten", displayMode: .inline).navigationBarBackButtonHidden(true)
                            }.onDisappear() {
                                self.selectedUser = nil
                                self.editUserClicked = false
                            }
                    }
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            self.createNewUserClicked = true
                        }) {
                            VStack {
                                Image("icon_person_add").resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(10)
                            }
                            .background(Color(UIColor(hex: ColorValue.turquoise))).clipShape(Circle()).foregroundColor(Color.black)
                            .frame(alignment: .bottomTrailing)
                        }.padding(.horizontal, 20)
                            .sheet(isPresented: self.$createNewUserClicked) {
                                LazyView {
                                    NavigationView {
                                        AdminUserCreateView()
                                    }.navigationBarTitle("Profil anlegen", displayMode: .inline).navigationBarBackButtonHidden(true)
                                }
                        }
                    }
                    
                }.padding(.vertical, 10)
            }
            .navigationBarTitle("Personen", displayMode: .inline).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: .ADMIN)
            )
        }.padding(.bottom, 20)
        
    }
    
    func setColors(role: UserRole) {
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

struct AdminUsersOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        AdminUsersOverviewView()
    }
}
