//
//  GeneralMenuDishesAdapter.swift
//  teamA
//
//  Created by FMA1 on 25.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct GeneralMenuDishesAdapter: View {
    
    let dish: Dish
    
    var body: some View {
        HStack {
            
            Text("\(self.dish.name)")
                .padding(3)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .border(Color.gray)
                .multilineTextAlignment(.leading)
            
            Text("\(self.dish.price) €")
                .padding(3)
                .multilineTextAlignment(.leading)
                
                .frame(minWidth: 80, alignment: .leading).background(Color(UIColor(hex: ColorValue.generalMenu)))
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .leading)
    }
}

struct GeneralMenuDishesAdapter_Previews: PreviewProvider {
    static var previews: some View {
        GeneralMenuDishesAdapter(dish: Dish(companyReference: "", name: "Wasser", description: "", price: "5", type: .DRINKS))
    }
}
