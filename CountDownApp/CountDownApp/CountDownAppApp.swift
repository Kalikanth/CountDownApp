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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CountDownTimer(viewModel: TimerViewModel(totalDuration: 60))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
