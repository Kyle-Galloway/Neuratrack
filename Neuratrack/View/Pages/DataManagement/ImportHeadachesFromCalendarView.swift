//
//  ImportHeadachesFromCalendarView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import EventKit
struct ImportHeadachesFromCalendarView: View {
    private var importer: EventKitEventImporter?
    @State var numberOfEvents: Int? = 0
    @State private var ekEvents: [EKEvent]?
    @State private var events: [HeadacheEvent] = [HeadacheEvent]()
    
    
    init() {
        do
        {
            self.importer = try EventKitEventImporter()
            self.numberOfEvents = 0
        }catch
        {
            numberOfEvents = nil
        }
    }
    
    var body: some View {
        NavigationStack
        {
            //VStack(alignment: .leading)
            List{
                
                Button("Load Events From Calendar")
                {
                    print("Load Events Button Pressed")
                    ekEvents = importer?.loadEventsiOS17()
                }
                Text("Events: \(ekEvents?.count ?? 0)")
                Button("Convert Events")
                {
                    events = (importer?.convertEventKitEventsToHeadacheEvents(foundEventsIn: ekEvents!))!
                }
                Text("Converted Events: \(events.count)")
                List(events)
                { evnt in
                    Text("\(evnt.repr)")
                }
                
            }.navigationTitle("Import").navigationBarTitleDisplayMode(.inline).padding()
        }
        
    }
}

#Preview {
    ImportHeadachesFromCalendarView()
}
