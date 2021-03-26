//
//  RestaurantModel.swift
//  Restaurants
//
//  Created by Aditya Das on 3/19/21.
//

import SwiftUI
import Combine


struct RestaurantModel: Identifiable{
    var id: Int
    var name: String
    var type: String
    var address: String
    var phone: String
    var description: String
    var imageName: String
}

final class RestaurantDataStore: ObservableObject{
    static let shared = RestaurantDataStore()
    @Published  var dummyRestaurants : [RestaurantModel] =
      [
        .init(id: 1, name: "Gus's Pizza", type: "Italian", address: "829 S Rural Rd, Tempe, AZ 85281", phone: "4809902234", description:
                "Specializes in New York style pizza", imageName: "pizza"),
          
        .init(id: 2, name: "Haji Babaa", type: "Mediterranean", address: "Apache Blvd", phone: "4809902235", description: "Known for its Shawarma and Gyro",imageName: "chicken"),
          
        .init(id: 3, name: "Chutneys", type: "Indian", address: "Baseline road", phone: "4809902236", description: " Has the best weekend buffets and Biryanis",imageName: "rice"),
          
        .init(id: 4, name: "Popeyes", type: "American", address: "Broadway road", phone: "4809902237", description: "Known for the chicken sandwich combos",imageName: "burger")
      
      ]
}

