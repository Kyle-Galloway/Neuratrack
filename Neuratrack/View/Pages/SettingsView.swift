//
//  SettingsView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 23/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State var startTrackingDate: Date = Date()
    
    var body: some View {
        
        NavigationStack
        {
            List{
            DatePicker("Tracking Date",selection: $startTrackingDate,displayedComponents: .date)//.padding()
            
                NavigationLink(destination: ImportHeadachesFromCalendarView())
                {
                    Label("Import",systemImage: "square.and.arrow.down").navigationTitle("Settings").navigationBarTitleDisplayMode(.inline)//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)
                }
                
                NavigationLink(destination: ExportDataView())
                {
                    Label("Export",systemImage: "square.and.arrow.up")//.padding().foregroundColor(.white).background(.blue).clipShape(.capsule).dynamicTypeSize(.accessibility2)//TODO: Export as JSON
                    /*
                     Button(action:{})
                     {
                     Label("Export",systemImage: "square.and.arrow.up").padding()
                     }.buttonStyle(.bordered)*/
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
