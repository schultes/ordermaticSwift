//
//  DatabaseService.swift
//  teamA
//
//  Created by FMA1 on 19.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

class DatabaseService {
    static func  setCompany(id: String, company: Company, callback: @escaping (String?) -> ()) {
        TPFirebaseFirestore.setDocument(collectionName: Company.COLLECTION_NAME, documentId: id, data: Company.toMap(company: company), callback: callback)
    }

    static func getCompany(id: String, callback: @escaping (Company?) -> ()) {
        TPFirebaseFirestore.getDocument(collectionName: Company.COLLECTION_NAME, documentId: id) {
            result, error in
            if let resultObject = result {
                callback(Company.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func  addDish(dish: Dish, callback: @escaping (Dish?) -> ()) {
        TPFirebaseFirestore.addDocument(collectionName: Dish.COLLECTION_NAME, data: Dish.toMap(dish: dish)) {
            result, error in
            if let resultObject = result {
                callback(Dish.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func getDish(id: String, callback: @escaping (Dish?) -> ()) {
        TPFirebaseFirestore.getDocument(collectionName: Dish.COLLECTION_NAME, documentId: id) {
            result, error in
            if let resultObject = result {
                callback(Dish.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func getDishes(companyAccount: CompanyAccount, callback: @escaping ([Dish]) -> ()) {
        TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Dish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id)) {
            result, _ in
            if let resultObject = result {
                var dishes = [Dish]()
                for element in resultObject {
                    if let temp = Dish.toObject(documentId: element.documentId, map: element.data) {
                        dishes.append(temp)
                    }
                }

                callback(dishes)
            }
        }
    }

    static func getDishes(companyAccount: CompanyAccount, dishesType: DishesType, callback: @escaping ([Dish]) -> ()) {
        TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Dish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "type", value: dishesType.rawValue)) {
            result, _ in
            if let resultObject = result {
                var dishes = [Dish]()
                for element in resultObject {
                    if let temp = Dish.toObject(documentId: element.documentId, map: element.data) {
                        dishes.append(temp)
                    }
                }

                callback(dishes)
            }
        }
    }

    static func getDishesIdsByTypes(companyAccount: CompanyAccount, dishesTypes: [DishesType], callback: @escaping ([String]) -> ()) {
        if dishesTypes.count > 0 {
            let list = dishesTypes.map {
                type in
                type.rawValue
            }

            TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Dish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereIn(field: "type", value: list)) {
                result, _ in
                if let resultObject = result {
                    var ids = [String]()
                    for element in resultObject {
                        let dishObject = Dish.toObject(documentId: element.documentId, map: element.data)
                        if dishObject != nil {
                            ids.append(element.documentId)
                        }
                    }

                    callback(ids)
                }
            }
        }

        callback([])
    }

    static func getDishesByTypes(companyAccount: CompanyAccount, dishesTypes: [DishesType], callback: @escaping ([Dish]) -> ()) {
        if dishesTypes.count > 0 {
            let list = dishesTypes.map {
                type in
                type.rawValue
            }

            TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Dish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereIn(field: "type", value: list)) {
                result, _ in
                if let resultObject = result {
                    var dishes = [Dish]()
                    for element in resultObject {
                        if let temp = Dish.toObject(documentId: element.documentId, map: element.data) {
                            dishes.append(temp)
                        }
                    }

                    callback(dishes)
                }
            }
        }

        callback([])
    }

    static func addDishesSnapshotListener(companyAccount: CompanyAccount, dishesType: DishesType, callback: @escaping ([Dish]) -> ()) {
        TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Dish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "type", value: dishesType.rawValue)) {
            result, _ in
            if let resultObject = result {
                var dishes = [Dish]()
                for element in resultObject {
                    if let temp = Dish.toObject(documentId: element.documentId, map: element.data) {
                        dishes.append(temp)
                    }
                }

                callback(dishes)
            }
        }
    }

    static func editDish(dish: Dish, callback: @escaping (String?) -> ()) {
        if let dishDocumentId = dish.documentId {
            TPFirebaseFirestore.updateDocument(collectionName: Dish.COLLECTION_NAME, documentId: dishDocumentId, data: Dish.toMap(dish: dish)) {
                error in
                callback(error)
            }
        }

        if dish.documentId == nil {
            callback("Object is malformed")
        }
    }

    static func deleteDish(dish: Dish, callback: @escaping (String?) -> ()) {
        if let dishDocumentId = dish.documentId {
            TPFirebaseFirestore.deleteDocument(collectionName: Dish.COLLECTION_NAME, documentId: dishDocumentId) {
                error in
                callback(error)
            }
        }

        if dish.documentId == nil {
            callback("Object is malformed")
        }
    }

    static func  addOrder(order: Order, callback: @escaping (Order?) -> ()) {
        TPFirebaseFirestore.addDocument(collectionName: Order.COLLECTION_NAME, data: Order.toMap(order: order)) {
            result, error in
            if let resultObject = result {
                callback(Order.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func addOrderSnapshotListener(companyAccount: CompanyAccount, isActive: Bool, callback: @escaping ([Order]) -> ()) {
        TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Order.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "isActive", value: isActive)) {
            result, _ in
            if let resultObject = result {
                var orders = [Order]()
                for element in resultObject {
                    if let temp = Order.toObject(documentId: element.documentId, map: element.data) {
                        orders.append(temp)
                    }
                }

                callback(orders)
            }
        }
    }

    static func getActiveOrderByTableNumber(companyAccount: CompanyAccount, tableNumber: String, callback: @escaping (Order?) -> ()) {
        TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: Order.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "tableNumber", value: tableNumber).whereEqualTo(field: "isActive", value: true)) {
            result, error in
            if let resultObject = result {
                if resultObject.count > 0 {
                    callback(Order.toObject(documentId: resultObject[0].documentId, map: resultObject[0].data))
                } else {
                    callback(nil)
                }
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func editOrder(order: Order, callback: @escaping (String?) -> ()) {
        if let orderDocumentId = order.documentId {
            TPFirebaseFirestore.updateDocument(collectionName: Order.COLLECTION_NAME, documentId: orderDocumentId, data: Order.toMap(order: order)) {
                error in
                callback(error)
            }
        }

        if order.documentId == nil {
            callback("Object is malformed")
        }
    }

    static func  addOrderedDish(orderedDish: OrderedDish, callback: @escaping (OrderedDish?) -> ()) {
        TPFirebaseFirestore.addDocument(collectionName: OrderedDish.COLLECTION_NAME, data: OrderedDish.toMap(ordered: orderedDish)) {
            result, error in
            if let resultObject = result {
                callback(OrderedDish.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func getOrderedDishes(order: Order, callback: @escaping ([OrderedDish]) -> ()) {
        if let orderDocumentId = order.documentId {
            TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "orderReference", value: orderDocumentId)) {
                result, _ in
                if let resultObject = result {
                    var orders = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orders.append(temp)
                        }
                    }

                    callback(orders)
                }
            }
        }

        if order.documentId == nil {
            callback([])
        }
    }

    static func getAllOrderedDishesOfOrderSnapshotListener(companyAccount: CompanyAccount, order: Order, callback: @escaping ([OrderedDish]) -> ()) {
        if let orderDocumentId = order.documentId {
            TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "orderReference", value: orderDocumentId)) {
                result, error in
                if let resultObject = result {
                    var orderedDishes = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orderedDishes.append(temp)
                        }
                    }

                    callback(orderedDishes)
                }

                if error != nil {
                    callback([])
                }
            }
        }
    }

    static func getOrderDishesByStatusSnapshotListener(companyAccount: CompanyAccount, order: Order, status: OrderDishesStatus, callback: @escaping ([OrderedDish]) -> ()) {
        if let orderDocumentId = order.documentId {
            TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereEqualTo(field: "orderReference", value: orderDocumentId).whereEqualTo(field: "status", value: status.rawValue)) {
                result, error in
                if let resultObject = result {
                    var orderedDishes = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orderedDishes.append(temp)
                        }
                    }

                    callback(orderedDishes)
                }

                if error != nil {
                    callback([])
                }
            }
        }
    }

    static func getAllOrderDishesOfMultipleOrdersSnapshotListener(companyAccount: CompanyAccount, orderIds: [String], callback: @escaping ([OrderedDish]) -> ()) {
        if orderIds.count > 0 {
            TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereIn(field: "orderReference", value: orderIds)) {
                result, error in
                if let resultObject = result {
                    var orderedDishes = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orderedDishes.append(temp)
                        }
                    }

                    callback(orderedDishes)
                }

                if error != nil {
                    callback([])
                }
            }
        }
    }

    static func getAllOrderDishesByStatusSnapshotListener(companyAccount: CompanyAccount, orderIds: [String], status: OrderDishesStatus, callback: @escaping ([OrderedDish]) -> ()) {
        if orderIds.count > 0 {
            TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereIn(field: "orderReference", value: orderIds).whereEqualTo(field: "status", value: status.rawValue)) {
                result, error in
                if let resultObject = result {
                    var orderedDishes = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orderedDishes.append(temp)
                        }
                    }

                    callback(orderedDishes)
                }

                if error != nil {
                    callback([])
                }
            }
        }
    }

    static func getAllOrderDishesByStatus(companyAccount: CompanyAccount, orderIds: [String], status: OrderDishesStatus, callback: @escaping ([OrderedDish]) -> ()) {
        if orderIds.count > 0 {
            TPFirebaseFirestore.getDocuments(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: OrderedDish.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereIn(field: "orderReference", value: orderIds).whereEqualTo(field: "status", value: status.rawValue)) {
                result, error in
                if let resultObject = result {
                    var orderedDishes = [OrderedDish]()
                    for element in resultObject {
                        if let temp = OrderedDish.toObject(documentId: element.documentId, map: element.data) {
                            orderedDishes.append(temp)
                        }
                    }

                    callback(orderedDishes)
                }

                if error != nil {
                    callback([])
                }
            }
        }
    }

    static func editOrderedDish(orderedDish: OrderedDish, callback: @escaping (String?) -> ()) {
        if let orderedDishDocumentId = orderedDish.documentId {
            TPFirebaseFirestore.updateDocument(collectionName: OrderedDish.COLLECTION_NAME, documentId: orderedDishDocumentId, data: OrderedDish.toMap(ordered: orderedDish)) {
                error in
                callback(error)
            }
        }

        if orderedDish.documentId == nil {
            callback("Object is malformed")
        }
    }

    static func  addUser(user: User, callback: @escaping (User?) -> ()) {
        TPFirebaseFirestore.addDocument(collectionName: User.COLLECTION_NAME, data: User.toMap(user: user)) {
            result, error in
            if let resultObject = result {
                callback(User.toObject(documentId: resultObject.documentId, map: resultObject.data))
            }

            if error != nil {
                callback(nil)
            }
        }
    }

    static func addUsersSnapshotListener(companyAccount: CompanyAccount, callback: @escaping ([User]) -> ()) {
        TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: User.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id)) {
            result, _ in
            if let resultObject = result {
                var users = [User]()
                for element in resultObject {
                    if let temp = User.toObject(documentId: element.documentId, map: element.data) {
                        users.append(temp)
                    }
                }

                callback(users)
            }
        }
    }

    static func addOtherUsersSnapshotListener(companyAccount: CompanyAccount, callback: @escaping ([User]) -> ()) {
        TPFirebaseFirestore.addCollectionSnapshotListener(queryBuilder: TPFirebaseFirestoreQueryBuilder(collectionName: User.COLLECTION_NAME).whereEqualTo(field: "companyReference", value: companyAccount.id).whereNotEqualTo(field: "role", value: UserRole.ADMIN.rawValue)) {
            result, _ in
            if let resultObject = result {
                var users = [User]()
                for element in resultObject {
                    if let temp = User.toObject(documentId: element.documentId, map: element.data) {
                        users.append(temp)
                    }
                }

                callback(users)
            }
        }
    }

    static func editUser(user: User, callback: @escaping (String?) -> ()) {
        if let userDocumentId = user.documentId {
            TPFirebaseFirestore.updateDocument(collectionName: User.COLLECTION_NAME, documentId: userDocumentId, data: User.toMap(user: user)) {
                error in
                callback(error)
            }
        }

        if user.documentId == nil {
            callback("Object is malformed")
        }
    }

    static func deleteUser(user: User, callback: @escaping (String?) -> ()) {
        if let userDocumentId = user.documentId {
            TPFirebaseFirestore.deleteDocument(collectionName: User.COLLECTION_NAME, documentId: userDocumentId) {
                error in
                callback(error)
            }
        }

        if user.documentId == nil {
            callback("Object is malformed")
        }
    }
}
