//
//  GeneralUserLoginView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralUserLoginView: View {
    var user: User
    private let zIndex = 8.0
    
    @ObservedObject var viewController = GeneralUserLoginViewController()
    @State var password: String = "Test1234#"
    
    var body: some View {
        Group {
            if !viewController.isUserSignedIn {
                VStack {
                    Text("Hallo \(user.name), gib bitte dein Passwort ein!").padding(.bottom, 20)
                    SecureField("Passwort", text: $password)
                            .font(.system(size: 14))
                            .padding(12)
                            .multilineTextAlignment(.center)
                            .border(Color(UIColor.lightGray), width: 1)
                            .shadow(radius: 5)
                            .padding(.horizontal, 20)
                            .cornerRadius(10)
                            .zIndex(zIndex)
                            .padding(.bottom, 50)
                    Button(action: { self.viewController.onLoginClicked(passwordOne: self.password, correctPassword: self.password) }) {
                        Text("Anmelden")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold))
                            .background(Color(UIColor(hex: ColorValue.purple)))
                            .cornerRadius(10)
                    }.padding(.horizontal, 50).alert(isPresented: $viewController.showError) {
                        Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))
                    }.alert(isPresented: $viewController.showError) {
                        Alert(title: Text("Error"), message: Text(viewController.errorMessage), dismissButton: .default(Text("Ok")))
                    }
                }.navigationBarHidden(false)
                    .navigationBarTitle("\(user.role.rawValue.capitalized)-Login", displayMode: .inline).navigationBarItems(leading: Image(ImageHelper.getUserRoleImageName(user: user)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.horizontal, 10))
            } else {
                mainView()
            }
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    func mainView() -> AnyView {
        switch user.role {
            case .ADMIN: return AnyView(AdminDashboardView())
            case .BAR: return AnyView(KitchenBarDashboardView(user: user))
            case .KITCHEN: return AnyView(KitchenBarDashboardView(user: user))
            case .SERVICE: return AnyView(ServiceDashboardView(user: user))
        }
    }
}

struct GeneralUserLoginView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralUserLoginView(user: User(companyReference: "", name: "User", password: "", role: .ADMIN))
    }
}
