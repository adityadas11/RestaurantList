//
//  RestaurantList.swift
//  Restaurants
//
//  Created by Aditya Das on 3/19/21.
//

import SwiftUI

struct RestaurantList: View {
    @ObservedObject var restData = RestaurantDataStore.shared
    @State private var selectedItemId: UUID?
    @State private var searchText = ""
    var body: some View {
        NavigationView{
            List{
                SearchBar(text: $searchText)
                    .padding(.top,10)
                ForEach(restData.dummyRestaurants
                        .filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })
                ){restaurant in
                    
                    CardView(rest: restaurant)
                    
                }.navigationBarItems(
                    trailing: NavigationLink(
                                                                                                            destination: NewRestaurant(restData: restData),
                                                                                                                                label: {
                                                                                                                                    Label("Add", systemImage: "plus.app.fill")
                                                                                                                                }))
                    
            }.navigationTitle("Restaurants")
        }
        
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RestaurantList()
        }
    }
        
}
