//
//  ContentView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var testData: [HeadacheEvent]
    
    init() {
        do
        {
            
            self.testData = [HeadacheEvent(date: try Date("2021-01-01T12:30:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: nil, note: nil),HeadacheEvent(date: try Date("2022-02-02T12:40:00Z",strategy:.iso8601), analgesiaTaken: false, analgesics: nil, note: nil),HeadacheEvent(date: try Date("2022-02-03T12:40:00Z",strategy:.iso8601), analgesiaTaken: false, analgesics: nil, note: nil)]
        }catch
        {
            print("Error Creating Test Data")
            self.testData = []
        }
    }
    
    
    var body: some View {
        NavigationStack
        {
            //VStack(alignment: .leading)
            List
            {
                
                NavigationLink(destination: HeadachesLoggerView(headacheEvents: testData, testHeadacheEventList: testData, presentAddHeadacheSheet: false))
                {
                    Label("Headaches", systemImage: "calendar.circle").symbolRenderingMode(.palette)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                }.navigationBarTitle("Neuratrack",displayMode: .automatic)
                
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
        }
    }
}

#Preview {
    
    ContentView()
}
