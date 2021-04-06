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
    @State private var editMode = EditMode.inactive

    var body: some View {
        NavigationView{
            List{
                SearchBar(text: $searchText)
                    .padding(.top,10)
                ForEach(restData.dummyRestaurants
                        .filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })
                ){restaurant in
                    
                    CardView(rest: restaurant)
                    
                }
                .onDelete(perform: delete)
                
                    
            }
            .navigationBarItems(leading: EditButton(),trailing: addButton)
            .navigationTitle("Restaurants")
            .environment(\.editMode, $editMode)
            
        }
    }
    func delete(at offsets: IndexSet) {
        restData.dummyRestaurants.remove(atOffsets: offsets)
        }
    private var addButton: some View {
            switch editMode {
            case .inactive:
                return AnyView((NavigationLink(
                                destination: NewRestaurant(restData: restData),
                                label: {
                                    Label("Add", systemImage: "plus.app.fill")
                                })))
            default:
                return AnyView(EmptyView())
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


