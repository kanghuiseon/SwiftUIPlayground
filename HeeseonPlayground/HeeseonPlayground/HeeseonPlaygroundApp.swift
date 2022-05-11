//
//  HeeseonPlaygroundApp.swift
//  HeeseonPlayground
//
//  Created by 강희선 on 2022/05/12.
//

import SwiftUI

@main
struct HeeseonPlaygroundApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
