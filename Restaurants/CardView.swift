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
            Image(uiImage: rest.imageName)
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
                Button {
                    let telephone = "tel://"
                    let formattedString = telephone + rest.phone
                    guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                } label: {
                    Label("\(rest.phone)", systemImage: "phone.fill")
                }.buttonStyle(BorderlessButtonStyle())

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
    }
}
