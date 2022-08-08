//
//  Colors.swift
//  teamA
//
//  Created by FMA1 on 23.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation
import SwiftUI

class ColorValue {
    
    static let purple = "#6200EE"
    static let rosa = "#FAA0A2"
    static let turquoise = "#A8E4BF"
    static let redLight = "#FAA0A2"
    static let darkGray = "#4E4C4A"
    
    static let generalMenu = "#DCDDD7"
    
    static let userAdmin = "#FAA0A2"
    static let userBar = "#B1CBEA"
    static let userKitchen = "#D3C6ED"
    static let userService = "#FFF0A1"
    
    static let userBarSelected = "#879CB2"
    static let userKitchenSelected = "#9F95B2"
    static let userServiceSelected = "#B2A772"

    static let adminEditUser = "#F7D1CD"
    static let adminEditDrinks = "#B2DFDC"
    static let adminEditStarters = "#FEE7C4"
    static let adminEditMainDishes = "#FFD6A5"
    static let adminEditDesserts = "#D8C1A2"
    
    static let serviceOrderedDishes = "#F9E285"
    static let serviceSend = "#A1ECCD"
    static let servicePayment = "#FEA7B7"
    static let serviceDone = "#719E62"
    static let serviceReady = "#577091"
    static let serviceUndone = "#A55151"
    static let servicePaymentCash = "#A1ECCD"
    static let servicePaymentCard = "#A8E4E2"
    
}

class ColorHelper {
    static func getUserButtonBackgroundColor(user: User) -> UIColor {
        switch user.role {
        case .ADMIN:
            return UIColor(hex: ColorValue.userAdmin)
        case .BAR:
            return UIColor(hex: ColorValue.userBar)
        case .KITCHEN:
            return UIColor(hex: ColorValue.userKitchen)
        case .SERVICE:
            return UIColor(hex: ColorValue.userService)
        }
    }
}


extension UIColor {
    public convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            var r: CGFloat = 0.0
            var g: CGFloat = 0.0
            var b: CGFloat = 0.0
            var a: CGFloat = 1.0
            
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            if ((cString.count) == 8) {
                r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
                g =  CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
                b = CGFloat((rgbValue & 0x0000FF)) / 255.0
                a = CGFloat((rgbValue & 0xFF000000)  >> 24) / 255.0
            } else if ((cString.count) == 6){
                r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
                g =  CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
                b = CGFloat((rgbValue & 0x0000FF)) / 255.0
                a =  CGFloat(1.0)
            }
            
            self.init(  red: r,
                        green: g,
                        blue: b,
                        alpha: a
            )
    }
}

