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
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Restaurant.entity(), sortDescriptors: []) var restaurantList: FetchedResults<Restaurant>
   
    
    var body: some View {
        NavigationView{
            List{
                    
                    HStack{
                        SearchBar(text: $searchText)
                    }.padding(.top,10)
                
                
                ForEach(restaurantList
                            .filter({ if searchText.isEmpty{return true} else{ return $0.name!.contains(searchText) || $0.type!.contains(searchText) }}), id: \.id
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
        offsets.map{restaurantList[$0] }.forEach(viewContext.delete)
        do{
            try viewContext.save()
        }
        catch{
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
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




