//
//  InventoryTrackerApp.swift
//  InventoryTracker
//
//  Created by Olufayo Emmanuel on 02/02/2026.
//

import SwiftUI

@main
struct InventoryTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
