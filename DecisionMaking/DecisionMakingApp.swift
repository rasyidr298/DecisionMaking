//
//  PuzzleKuApp.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 30/03/22.
//

import SwiftUI

@main
struct PuzzleKuApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(GoalsViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
