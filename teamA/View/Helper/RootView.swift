//
//  RootView.swift
//  teamA
//
//  Created by FMA1 on 25.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct RootView: View {

    var body: some View {
        NavigationView {
            Group {
                if AuthenticationService.getCurrentCompanyAccount() != nil {
                    GeneralChooseAccountView()
                } else {
                    AuthenticationBusinessLoginView()
                }
            }
        }
    }
}

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
