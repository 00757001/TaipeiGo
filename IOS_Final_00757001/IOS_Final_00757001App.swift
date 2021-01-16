//
//  IOS_Final_00757001App.swift
//  IOS_Final_00757001
//
//  Created by User08 on 2020/12/21.
//

import SwiftUI

@main
struct IOS_Final_00757001App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
