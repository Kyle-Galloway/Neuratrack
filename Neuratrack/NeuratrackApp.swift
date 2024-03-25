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
            /*
            let config1 = ModelConfiguration(for: HeadacheEvent.self)
            print(config1.debugDescription)
            print(" ")
            let config2 = ModelConfiguration(for: Medication.self)
            print(config2.debugDescription)
            print(" ")
            self.modelCont = try ModelContainer(for: HeadacheEvent.self, Medication.self, configurations: config1, config2)
            */
            
            let config = ModelConfiguration(for: HeadacheEvent.self,Medication.self,AnalgesicMedication.self,ProphylacticMedication.self,OtherMedication.self)
            print(config.debugDescription)
            self.modelCont = try ModelContainer(for: HeadacheEvent.self, Medication.self,AnalgesicMedication.self,ProphylacticMedication.self,OtherMedication.self, configurations: config)
            self.modelCont.mainContext.autosaveEnabled = false
            print(modelCont.schema)
        }catch
        {
            fatalError("Couldn't create model container: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(modelCont)
    }
}
