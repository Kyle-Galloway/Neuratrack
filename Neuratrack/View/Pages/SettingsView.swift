//
//  SettingsView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 23/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State var startTrackingDate: Date
    @State var calendarID: String
    @State var eventID: String
    @State var errorAlertIsPresented: Bool = false
    @Environment(\.modelContext) var modelContext
    
    init()
    {
        let storedDate = UserDefaults.standard.value(forKey: "StartTrackingDate") as? Date
        let storedCalendarID = UserDefaults.standard.string(forKey: "CalendarID") ?? ""
        let storedEventID = UserDefaults.standard.string(forKey: "EventID") ?? ""
        _calendarID = State(initialValue: storedCalendarID)
        _eventID = State(initialValue: storedEventID)
        if storedDate != nil
        {
            _startTrackingDate = State(initialValue: storedDate!)
            
        }else
        {
            _startTrackingDate = State(initialValue: Date())
        }
    }
    
    var body: some View {
        
        NavigationStack
        {
            List
            {
                Section
                {
                    DatePicker("Tracking Started",selection: $startTrackingDate,displayedComponents: .date)//.padding()
                    
                    HStack
                    {
                        Text("Calendar ID")
                        Spacer()
                        TextField("Not Set", text: $calendarID).submitLabel(.done)
                    }
                    HStack
                    {
                        Text("Event ID")
                        Spacer()
                        TextField("Not Set", text: $eventID).submitLabel(.done)
                    }
                    
                    Button("Update")
                    {
                        print("Write To User Defaults")
                        UserDefaults.standard.setValue(startTrackingDate, forKey: "StartTrackingDate")
                        UserDefaults.standard.setValue(eventID, forKey: "EventID")
                        UserDefaults.standard.setValue(calendarID,forKey: "CalendarID")
                    }
                } header:
                {
                    Text("Settings")
                }
                
                Section{
                    NavigationLink(destination: ImportHeadachesFromCalendarView(startTrackingDate: startTrackingDate,eventID: eventID,calendarID: calendarID))
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
                    
                    Button("Delete All Data",role:.destructive)
                    {
                        do
                        {
                            
                            try modelContext.delete(model: HeadacheEvent.self)
                            try modelContext.delete(model: AnalgesicMedication.self)
                            try modelContext.delete(model: ProphylacticMedication.self)
                            try modelContext.delete(model: OtherMedication.self)
                        }
                        catch
                        {
                            print("Failed to delete data.")
                        }
                    }
                } header: {
                    Text("Data Management")
                }
            }
        }.onAppear{print("SettingsView  Appeared")}
    }
}

#Preview {
    SettingsView()
}
