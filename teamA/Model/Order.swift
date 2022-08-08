//
//  Order.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

struct Order: Serializable {
    
    let companyReference: String
    let userReference: String
    let tableNumber: String
    var isActive: Bool
    let createdAt: String
    let documentId: String?
    
    init(companyReference: String, userReference: String, tableNumber: String, isActive: Bool, createdAt: String, documentId: String? = nil) {
        self.companyReference = companyReference
        self.userReference = userReference
        self.tableNumber = tableNumber
        self.isActive = isActive
        self.createdAt = createdAt
        self.documentId = documentId
    }

    static let COLLECTION_NAME = "orders"
    
    static func toMap(order: Order) -> [String: Any] {
        return ["companyReference": order.companyReference, "userReference": order.userReference, "tableNumber": order.tableNumber, "isActive": order.isActive, "createdAt": order.createdAt]
    }

    static func toObject(documentId: String, map: [String: Any]) -> Order? {
        return map["companyReference"] == nil || map["userReference"] == nil || map["tableNumber"] == nil || map["isActive"] == nil || map["createdAt"] == nil ? nil : Order(companyReference: map["companyReference"]! as! String, userReference: map["userReference"]! as! String, tableNumber: map["tableNumber"]! as! String, isActive: map["isActive"]! as! Bool, createdAt: map["createdAt"] as! String, documentId: documentId)
    }
}
