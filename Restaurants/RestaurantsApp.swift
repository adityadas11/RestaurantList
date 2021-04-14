//
//  RestaurantsApp.swift
//  Restaurants
//
//  Created by Aditya Das on 3/17/21.
//

import SwiftUI

@main
struct RestaurantsApp: App {
    let persistenceContainer = PersistenceController.shared
    var restaurantData = RestaurantDataStore().self
    var body: some Scene {
        WindowGroup {
            RestaurantList().environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
