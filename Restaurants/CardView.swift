//
//  CardView.swift
//  Restaurants
//
//  Created by Aditya Das on 3/18/21.
//

import SwiftUI

struct CardView: View {
    let rest: RestaurantModel
    var body: some View {
        
        VStack {
            Image("\(rest.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:150.0)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 5))
            Text("\(rest.name)").font(.largeTitle)
            Text("\(rest.address)").font(.caption).foregroundColor(.gray)
            HStack {
                VStack(alignment: .leading) {
                    Text("\(rest.type)").font(.title3)
                }
                Spacer()
                Label("\(rest.phone)", systemImage: "phone.fill")
            }.padding()
            Text("\(rest.description)").font(.body)
            Divider()
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var rest = RestaurantDataStore.shared.dummyRestaurants[0]
    static var previews: some View {
        CardView(rest: rest)
//            .previewLayout(.fixed(width: 400, height: 60))
    }
}