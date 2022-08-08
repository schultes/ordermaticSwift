//
//  Company.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

struct Company: Serializable {
    let name: String
    let addressFirstLine: String
    let addressSecondLine: String
    let documentId: String?
    
    init(name: String, addressFirstLine: String, addressSecondLine: String, documentId: String? = nil) {
        self.name = name
        self.addressFirstLine = addressFirstLine
        self.addressSecondLine = addressSecondLine
        self.documentId = documentId
    }
    
    static let COLLECTION_NAME = "companies"
    
    static func toMap(company: Company) -> [String: Any] {
        return ["name": company.name, "adressFirstLine": company.addressFirstLine, "adressSecondLine": company.addressSecondLine]
    }

    static func toObject(documentId: String, map: [String: Any]) -> Company? {
        return map["name"] == nil || map["adressFirstLine"] == nil || map["adressSecondLine"] == nil ? nil : Company(name: map["name"]! as! String, addressFirstLine: map["adressFirstLine"]! as! String, addressSecondLine: map["adressSecondLine"]! as! String, documentId: documentId)
    }
}
