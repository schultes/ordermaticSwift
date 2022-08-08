//
//  GeneralChooseAccountAdapter.swift
//  teamA
//
//  Created by FMA1 on 25.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralChooseAccountAdapter: View {
    
    let user: User
    var color: UIColor
    var imageName: String
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName).resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.horizontal, 10)
                Text(user.name).frame(maxWidth: .infinity, alignment: .center)
                
                }.foregroundColor(.black)
            .padding(10)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
        .background(Color(color))
        .cornerRadius(10)
        
    }
    
    init(user: User) {
        self.user = user
        imageName = ImageHelper.getUserRoleImageName(user: user)
        color = ColorHelper.getUserButtonBackgroundColor(user: user)
    }

}
