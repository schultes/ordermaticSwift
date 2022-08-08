//
//  OrderedDish.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

struct OrderedDish: Serializable {
    let companyReference: String
    let userReference: String
    let orderReference: String
    let dishReference: String
    var status: OrderDishesStatus
    var comment: String
    let documentId: String?
    
    init(companyReference: String, userReference: String, orderReference: String, dishReference: String, status: OrderDishesStatus, comment: String, documentId: String? = nil) {
        self.companyReference = companyReference
        self.userReference = userReference
        self.orderReference = orderReference
        self.dishReference = dishReference
        self.status = status
        self.comment = comment
        self.documentId = documentId
    }
        
    static let COLLECTION_NAME = "orderedDishes"
    
    static func toMap(ordered: OrderedDish) -> [String: Any] {
        return [
            "companyReference": ordered.companyReference,
            "userReference": ordered.userReference,
            "orderReference": ordered.orderReference,
            "dishReference": ordered.dishReference,
            "status": ordered.status.rawValue,
            "comment": ordered.comment
        ]
    }

    static func toObject(documentId: String, map: [String: Any]) -> OrderedDish? {
        return
            map["companyReference"] == nil ||
            map["userReference"] == nil ||
            map["orderReference"] == nil ||
            map["dishReference"] == nil ||
            map["status"] == nil ||
            map["comment"] == nil ? nil :
                OrderedDish(
                    companyReference: map["companyReference"]! as! String,
                    userReference: map["userReference"]! as! String,
                    orderReference: map["orderReference"]! as! String,
                    dishReference: map["dishReference"]! as! String,
                    status: OrderDishesStatus(rawValue: map["status"]! as! String)!,
                    comment: map["comment"]! as! String,
                    documentId: documentId
        )
    }
}
