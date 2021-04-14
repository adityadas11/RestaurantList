//
//  CardView.swift
//  Restaurants
//
//  Created by Aditya Das on 3/18/21.
//

import SwiftUI

struct CardView: View {
    let rest: Restaurant
    var body: some View {
        
        VStack {
            Image(uiImage:UIImage(data: rest.image!) ?? UIImage(named: "default")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:150.0)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 5))
            Text(rest.name ?? "Name").font(.largeTitle)
            Text(rest.address ?? "Apache Blvd").font(.caption).foregroundColor(.gray)
            HStack {
                VStack(alignment: .leading) {
                    Text(rest.type ?? "American").font(.title3)
                }
                Spacer()
                Button {
                    let telephone = "tel://"
                    let formattedString = telephone + (rest.phone ?? "4809999999")
                    guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                } label: {
                    Label(rest.phone ?? "4809999999", systemImage: "phone.fill")
                }.buttonStyle(BorderlessButtonStyle())

            }.padding()
            Text(rest.detail ?? "Additional details").font(.body)
            Divider()
        }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var rest = Restaurant()
    static var previews: some View {
        CardView(rest: rest)
    }
}
