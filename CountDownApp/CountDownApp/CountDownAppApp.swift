//
//  CountDownAppApp.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import SwiftUI

@main
struct CountDownAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
