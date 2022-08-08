//
//  Dish.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

struct Dish: Serializable {
    let companyReference: String
    let name: String
    let description: String
    let price: String
    let type: DishesType
    let documentId: String?
    
    init(companyReference: String, name: String, description: String, price: String, type: DishesType, documentId: String? = nil) {
        self.companyReference = companyReference
        self.name = name
        self.description = description
        self.price = price
        self.type = type
        self.documentId = documentId
    }
    
    static let COLLECTION_NAME = "dishes"
    
    static func toMap(dish: Dish) -> [String: Any] {
        return ["companyReference": dish.companyReference, "name": dish.name, "description": dish.description, "price": dish.price, "type": dish.type.rawValue]
    }
    
    static func toObject(documentId: String, map: [String: Any]) -> Dish? {
        
        return
            map["companyReference"] == nil ||
                map["name"] == nil ||
                map["description"] == nil ||
                map["price"] == nil ||
                map["type"] == nil
                ? nil : Dish(companyReference: map["companyReference"]! as! String, name: map["name"]! as! String, description: map["description"]! as! String, price: map["price"]! as! String, type: DishesType(rawValue: map["type"]! as! String)!, documentId: documentId)
    }
}
