//
//  User.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

struct User: Serializable {
    let companyReference: String
    let name: String
    let password: String
    let role: UserRole
    let documentId: String?
    
    static let COLLECTION_NAME = "users"
    
    init(companyReference: String, name: String, password: String, role: UserRole, documentId: String? = nil) {
        self.companyReference = companyReference
        self.name = name
        self.password = password
        self.role = role
        self.documentId = documentId
    }
    
    static func toMap(user: User) -> [String: Any] {
        return ["companyReference": user.companyReference, "name": user.name, "password": user.password, "role": user.role.rawValue]
    }

    static func toObject(documentId: String, map: [String: Any]) -> User? {
        return
            map["companyReference"] == nil ||
            map["name"] == nil ||
            map["password"] == nil ||
            map["role"] == nil ? nil :
            User(companyReference: map["companyReference"]! as! String, name: map["name"]! as! String, password: map["password"]! as! String, role: UserRole(rawValue: map["role"]! as! String)!, documentId: documentId)
    }
}
