//
//  RestaurantsApp.swift
//  Restaurants
//
//  Created by Aditya Das on 3/17/21.
//

import SwiftUI

@main
struct RestaurantsApp: App {
    var restaurantData = RestaurantDataStore().self
    var body: some Scene {
        WindowGroup {
            RestaurantList()
        }
    }
}
