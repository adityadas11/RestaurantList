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
    var imageName: UIImage
}

final class RestaurantDataStore: ObservableObject{
    static let shared = RestaurantDataStore()
    @Published  var dummyRestaurants : [RestaurantModel] =
      [
        .init(id: 1, name: "Gus's Pizza", type: "Italian", address: "829 S Rural Rd, Tempe, AZ 85281", phone: "4808293995", description:
                "Specializes in New York style pizza", imageName: UIImage(named: "pizza")!),
          
        .init(id: 2, name: "Haji Babaa", type: "Mediterranean", address: "1513 E Apache Blvd, Tempe, AZ 85281", phone: "4808941905", description: "Known for its Shawarma and Gyro",imageName: UIImage(named: "chicken")!),
          
        .init(id: 3, name: "Chutneys", type: "Indian", address: "1801 E Baseline Rd STE 104, Tempe, AZ 85283", phone: "4807302555", description: " Has the best weekend buffets and Biryanis",imageName: UIImage(named: "rice")!),
          
        .init(id: 4, name: "Popeyes", type: "American", address: "457 W Broadway Rd, Tempe, AZ 85282", phone: "4802370896", description: "Known for the chicken sandwich combos",imageName: UIImage(named: "burger")!)
      
      ]
}

