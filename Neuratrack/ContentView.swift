//
//  ContentView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    
    var body: some View {
        NavigationStack
                {
                    //VStack(alignment: .leading)
                    List
                    {
                        
                        NavigationLink(destination: HeadachesLoggerView())
                        {
                            Label("Headaches", systemImage: "calendar.circle").symbolRenderingMode(.palette)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                        }.navigationBarTitle("Neuratrack",displayMode: .large)
                        
                        
                        NavigationLink(destination: MedicationManagementView())
                        {
                            Label("Medications", systemImage: "pill.circle").symbolRenderingMode(.palette)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                        }
                        
                        
                        
                        NavigationLink(destination: StatisticsView())
                        {
                            Label("Statistics", systemImage: "chart.pie").symbolRenderingMode(.palette)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                        }
                        
                        
                        NavigationLink(destination: SettingsView())
                        {
                            Label("Settings", systemImage: "gear").symbolRenderingMode(.palette)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                        }
                        //NavigationLink(destination: AddAnalgesicView()){Label("Settings",systemImage: "gear.circle").symbolRenderingMode(.palette)}
                        
                    }
                }.onAppear{print("ContentView Appeared")}

    }
}

#Preview {
    
    do
    {
        let dataConfiguration = ModelConfiguration(for: HeadacheEvent.self,AnalgesicMedication.self,ProphylacticMedication.self,OtherMedication.self,isStoredInMemoryOnly: true)
        let dataContainer = try ModelContainer(for: HeadacheEvent.self, AnalgesicMedication.self,ProphylacticMedication.self,OtherMedication.self, configurations: dataConfiguration)
        
        let testMedication =  try AnalgesicMedication(name: "Test Medication", dosage: "Test Dosage", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())
        let testEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, note: "")
        //let testEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [], note: "")
        dataContainer.mainContext.insert(testMedication)
        dataContainer.mainContext.insert(testEvent)
        
        return ContentView().modelContainer(dataContainer)
    }
    catch
    {
        fatalError("Failed to create model container for preview")
    }
    
    
}
