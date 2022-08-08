//
//  Validator.swift
//  teamA
//
//  Created by FMA1 on 24.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class Validator {
    
    private var errorMessages = [String]()
    
    func checkForEmailPattern(email: String) {
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", Validator.EMAIL_PATTERN)
        let result = emailPredicate.evaluate(with: email)
        if !result { errorMessages.append("Invalid email!")}
    }
    
    func checkForPasswordComplexity(password: String) {
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", Validator.PASSWORD_PATTERN)
        let result = passwordPredicate.evaluate(with: password)
        if !result { errorMessages.append("Invalid password: You need at least 6 digits, including uppercase, lowercase and a special character!")}
    }
    
    func checkForPasswordEquality(passwordOne: String, passwordTwo: String) {
        let result = passwordOne == passwordTwo
        if !result { errorMessages.append("Invalid password: Provided passwords are not equal!")}
    }
    
    func isValid() -> Bool {
        return errorMessages.isEmpty
    }
    
    func getErrorMessages() -> [String] {
        return errorMessages
    }
    
    static private let PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{4,}$"
    static private let EMAIL_PATTERN = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
    "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
    "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
    "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
    "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
    "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
    "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    
}
