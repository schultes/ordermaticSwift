//
//  GeneralMenuDishesView.swift
//  teamA
//
//  Created by FMA1 on 20.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralMenuDishesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewController = GeneralMenuDishesViewController()
    
    var dishesType: DishesType
    var dishes = [Dish]()
    
    init(dishesType: DishesType) {
        self.dishesType = dishesType
        viewController.getDishes(dishesType: dishesType)
        dishes.append(Dish(companyReference: "", name: "Wasser", description: "", price: "12", type: .DRINKS))
    }
    
    var body: some View {
        ScrollView {
            
            ForEach(self.viewController.dishes, id: \.self.documentId) { dish in
                 
                    GeneralMenuDishesAdapter(dish: dish).padding(.vertical, 3)
                
            }.padding(.horizontal, 20).frame(maxWidth: .infinity)
            
            
        }.navigationBarTitle("\(dishesType.rawValue)", displayMode: .inline).navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            getBackButtonWithLogo(presentationMode: self.presentationMode, userRole: nil)
        )
    }
}

struct GeneralMenuDishesView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralMenuDishesView(dishesType: .DRINKS)
    }
}
