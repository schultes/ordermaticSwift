//
//  AuthenticationService.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

class AuthenticationService {
    static func createCompanyAccount(email: String, password: String, callback: @escaping (CompanyAccount?, String?) -> ()) {
        TPFirebaseAuthentication.signUp(email: email, password: password) {
            user, error in
            if let userObject = user {
                callback(CompanyAccount(id: userObject.uid, email: userObject.email), nil)
            }

            if let errorString = error {
                callback(nil, errorString)
            }
        }
    }

    static func signInToCompanyAccount(email: String, password: String, callback: @escaping (CompanyAccount?, String?) -> ()) {
        TPFirebaseAuthentication.signIn(email: email, password: password) {
            user, error in
            if let userObject = user {
                callback(CompanyAccount(id: userObject.uid, email: userObject.email), nil)
            }
            
            if let errorString = error {
                callback(nil, errorString)
            }
        }
    }

    static func signOutFromCompanyAccount() {
        TPFirebaseAuthentication.signOut()
    }

    static func getCurrentCompanyAccount() -> CompanyAccount? {
        let user = TPFirebaseAuthentication.getUser()
        if let userObject = user {
            return CompanyAccount(id: userObject.uid, email: userObject.email)
        }
        return nil
    }
}
