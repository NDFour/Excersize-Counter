//
//  Persistence.swift
//  PushUps Count
//
//  Created by mac on 2022/5/6.
//

import CoreData

struct PersistentController {
    static let shared = PersistentController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ExcersizeRecord")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        })
    }
    
}
