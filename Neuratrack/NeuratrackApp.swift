//
//  NeuratrackApp.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI
import SwiftData

@main
struct NeuratrackApp: App {
    
    var modelCont: ModelContainer
        
    init(){
        //TODO: Make container for all data types.
        do
        {
            let config1 = ModelConfiguration(for: HeadacheEvent.self)
            let config2 = ModelConfiguration(for: Medication.self)
            self.modelCont = try ModelContainer(for: HeadacheEvent.self, HeadacheEvent.self, configurations: config1, config2)
        }catch
        {
            fatalError("Couldn't create model container")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(modelCont)
    }
}
