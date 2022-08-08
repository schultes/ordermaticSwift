//
//  ImageHelper.swift
//  teamA
//
//  Created by FMA1 on 25.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

class ImageHelper {
    
    static func getUserRoleImageName(user: User) -> String {
        switch user.role {
        case .ADMIN:
            return "icon_person_edit"
        case .BAR:
            return "icon_bar"
        case .KITCHEN:
            return "icon_kitchen"
        case .SERVICE:
            return "icon_service"
        }
    }
    
    static func getLogoByUserRole(role: UserRole?) -> String {
        switch role {
        case .ADMIN:
            return "logo_admin"
        case .BAR:
            return "logo_bar"
        case .KITCHEN:
            return "logo_kitchen"
        case .SERVICE:
            return "logo_service"
        case .none:
            return "logo_neutral"
        }
    }
}

