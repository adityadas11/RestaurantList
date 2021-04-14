//
//  Persistence.swift
//  Restaurants
//
//  Created by Aditya Das on 4/12/21.
//

import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "RestaurantCoreDataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
