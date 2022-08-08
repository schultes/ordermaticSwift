//
//  BackButton.swift
//  teamA
//
//  Created by FMA1 on 29.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

func getBackButton(presentationMode: Binding<PresentationMode>) -> some View {
    return Button(action: {
        presentationMode.wrappedValue.dismiss()
    }) {
        HStack(spacing: 0) {
            Image(systemName: "chevron.left").font(.title)
        }
    }
}

func getBackButtonWithLogo(presentationMode: Binding<PresentationMode>, userRole: UserRole?) -> some View {
    return HStack {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left").font(.title)
            }
        }
        Image(ImageHelper.getLogoByUserRole(role: userRole)).resizable().frame(width: 30.0, height: 30.0, alignment: .leading).padding(.leading, 20)
    }
}

func getViewButton(imageName: String, title: String, color: UIColor, horizontalPadding: CGFloat) -> AnyView {
    let view =
        VStack {
            HStack {
                Image(imageName).resizable().frame(width: 40.0, height: 40.0, alignment: .leading).padding(.horizontal, 10)
                Text(title).frame(maxWidth: .infinity, alignment: .center).font(.system(size: 22))
                
            }.foregroundColor(.black)
                .padding(10)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
            .background(Color(color))
            .cornerRadius(10)
            .padding(.horizontal, horizontalPadding)
    return AnyView(view)
}

func getViewButton(imageName: String, title: String, color: UIColor) -> AnyView {
    let view =
        VStack {
            HStack {
                Image(imageName).resizable().frame(width: 40.0, height: 40.0, alignment: .leading).padding(.horizontal, 10)
                Text(title).frame(maxWidth: .infinity, alignment: .center).font(.system(size: 22))
                
            }.foregroundColor(.black)
                .padding(10)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .topLeading
        )
            .background(Color(color))
            .cornerRadius(10)
    return AnyView(view)
}

func getSmallViewButton(imageName: String, title: String, color: UIColor) -> AnyView {
    let view =
        HStack {
            VStack {
                Spacer()
                Image(imageName).resizable().frame(width: 40.0, height: 40.0, alignment: .leading).padding(.horizontal, 10)
                Spacer()
                Text(title).frame(maxWidth: .infinity, alignment: .center).font(.system(size: 14))
                Spacer()
            }.foregroundColor(.black)
                .padding(10)
        }
        .frame(
            maxWidth: 100, maxHeight: 100,
            alignment: .topLeading
        )
            .background(Color(color))
            .cornerRadius(10)
    return AnyView(view)
}

func getServiceViewButton(imageName: String, color: UIColor) -> AnyView {
    let view =
        
        Image(imageName).resizable().frame(width: 13, height: 13).padding(10)
        
        .background(Color(color)).cornerRadius(10).foregroundColor(Color.black)
        
    return AnyView(view)
}
