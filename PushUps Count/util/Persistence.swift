//
//  Persistence.swift
//  PushUps Count
//
//  Created by mac on 2022/5/6.
//

import CoreData

struct PersistentController {
    static let shared: PersistentController = .init()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ExcersizeRecord")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        })
    }
    
    // MARK: Save core data
    func save() {
        if self.container.viewContext.hasChanges {
            do {
                try self.container.viewContext.save()
            } catch {
                fatalError("Unresoled fatal error: \(error)")
            }
        }
    }
    
}
