//
//  PushUps_CountApp.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI

@main
struct PushUps_CountApp: App {

    var body: some Scene {
        // Use CoreData
        let persistentContainer = PersistentController.shared
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.container.viewContext)
        }
    }
}
