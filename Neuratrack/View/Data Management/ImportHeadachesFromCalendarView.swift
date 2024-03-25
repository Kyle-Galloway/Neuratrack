//
//  ImportHeadachesFromCalendarView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import EventKit
import SwiftData
import UniformTypeIdentifiers

struct ImportHeadachesFromCalendarView: View {
    @Query(sort: \HeadacheEvent.date) private var savedEvents: [HeadacheEvent]
    @Environment(\.modelContext) var modelContext
    
    @State private var importer: EventKitEventImporter?
    @State var importSources: [String] = ["Calendar","Neuratrack File"]
    @State var selectedSource: String = "Calendar"
    @State var numberOfEvents: Int? = 0
    @State private var ekEvents: [EKEvent] = [EKEvent]()
    @State private var importedEvents: [HeadacheEvent] = [HeadacheEvent]()
    @State private var startTrackingDate: Date
    @State private var isLoadCalendarEventsErrorSheetPresented: Bool = false
    @State private var isFileImporterPresented: Bool = false
    @State private var isFailedToLoadFileSheetPresented: Bool = false
    @State private var failedToInitialiseEventKitImporter: Bool = false
    @State private var eventID: String
    @State private var calendarID: String
    
    
    let neuratrackFileUTType: UTType = UTType(exportedAs: "com.kylegalloway.neuratrack", conformingTo: .json)
    
    init(startTrackingDate: Date, eventID: String, calendarID: String) {
        do
        {
            _importer = State(initialValue: EventKitEventImporter(startTrackingDate: startTrackingDate,eventID: eventID,calenderID: calendarID))
            _startTrackingDate = State(initialValue: startTrackingDate)
            _eventID = State(initialValue: eventID)
            _calendarID = State(initialValue: calendarID)
            self.numberOfEvents = 0
        }catch
        {
            numberOfEvents = nil
            failedToInitialiseEventKitImporter = true
        }
    }
    
    var body: some View {
        NavigationStack
        {
            //VStack(alignment: .leading)
            HStack
            {
                Text("Source")
                Picker("Source", selection: $selectedSource)
                {
                    ForEach(importSources,id:\.self)
                    {source in
                        Text("\(source)")
                    }
                }.pickerStyle(.segmented)
            }.navigationTitle("Import").navigationBarTitleDisplayMode(.inline).padding().alert("Error Initialising Importer", isPresented: $failedToInitialiseEventKitImporter)
            {
                Button("Ok",role: .cancel){}
                Button("Try Again")
                {
                    do
                    {
                        importer = try EventKitEventImporter(startTrackingDate: startTrackingDate,eventID: eventID, calenderID: calendarID)
                    }catch
                    {
                        failedToInitialiseEventKitImporter = true
                    }
                }
            }
            if selectedSource == "Calendar"
            {
                List{
                    
                    Button("Load Events From Calendar")
                    {
                        print("Load Events Button Pressed")
                        do
                        {
                            print("Entered do block")
                            Task{
                                ekEvents = try await importer!.loadEventsFromCalendar()
                            }
                            print("Exit do block")
                            
                        }catch
                        {
                            isLoadCalendarEventsErrorSheetPresented  = true
                        }
                    }.alert("Error Loading Events From Calendar", isPresented: $isLoadCalendarEventsErrorSheetPresented)
                    {
                        Button("Ok",role:.cancel){}
                    }
                    Text("Events: \(ekEvents.count)")
                    if !ekEvents.isEmpty
                    {
                        Button("Convert Events")
                        {
                            importedEvents = (importer?.convertEventKitEventsToHeadacheEvents(foundEventsIn: ekEvents))!
                        }
                        Text("Converted Events: \(importedEvents.count)")
                        Button("Save Converted Events")
                        {
                            print("Save Converted Events Button Pressed")
                            do
                            {
                                try modelContext.transaction
                                {
                                    for event in importedEvents.sorted(by: {$0.date > $1.date})
                                    {
                                        modelContext.insert(event)
                                    }
                                }
                                do
                                {
                                    try modelContext.save()
                                }catch
                                {
                                    print("Error saving data to swiftdata: \(error)")
                                }
                                
                            }catch
                            {
                                print("Error during swiftdata transaction: \(error)")
                            }
                            
                        }
                        if savedEvents.isEmpty
                        {
                            VStack{
                                Image(systemName: "exclamationmark.arrow.triangle.2.circlepath").dynamicTypeSize(.accessibility5)
                                Text("No Data")}
                            
                        }else
                        {
                            Text("Imported events require analgesic data from the notes section to be added manually")
                            ForEach(savedEvents,id:\.id)
                            { evnt in
                                Text("\(evnt.description)")
                            }
                        }
                    }
                    
                }
            }else
            {
                List{
                    
                    Button("Load From File")
                    {
                        print("Load Events Button Pressed")
                        isFileImporterPresented = true
                    }.fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [neuratrackFileUTType])
                    {result in
                        switch result
                        {
                            case .success(let url):
                                print(url.absoluteString)
                            case .failure(let error):
                                print(error)
                            isFailedToLoadFileSheetPresented = true
                            
                        }
                    }.alert("Error Loading From File", isPresented: $isFailedToLoadFileSheetPresented)
                    {
                        Button("Ok",role: .cancel){}
                    }
                    if !importedEvents.isEmpty
                    {
                        Text("Events Loaded: \(importedEvents.count)")
                        Button("Save Imported Events")
                        {
                            print("Save Imported Events Button Pressed")
                        }
                    }
                    
                }
            }
            
        }
        
    }
}

#Preview {
    var date = Date()
    return ImportHeadachesFromCalendarView(startTrackingDate: date,eventID: "",calendarID: "")
}

