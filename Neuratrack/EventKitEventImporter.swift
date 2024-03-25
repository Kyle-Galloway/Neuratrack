//
//  EventKitEventImporter.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import Foundation
import EventKit


class EventKitEventImporter: ObservableObject
{
    
    var eventStore: EKEventStore = EKEventStore()
    var headachesCalendarIdentifier: String = "Headache Tracking" // TODO: Make user defined
    var eventIdentifier: String = "Headache"// TODO: Make user defined
    var startTrackingDate: Date // TODO: Make user defined
    
    var foundEvents: [EKEvent] = [EKEvent]()
    var headacheEvents: [HeadacheEvent] = [HeadacheEvent]()
    
    init(startTrackingDate: Date, eventID: String, calenderID: String)
    {
        print("Importer Init")
        print("Provided Date: \(startTrackingDate)")
        self.startTrackingDate = startTrackingDate
        self.eventIdentifier = eventID
        self.headachesCalendarIdentifier = calenderID
        //startTrackingDate = try Date("2018-01-01T00:00:00Z", strategy: .iso8601)
        
    }
    /*
    func loadEvents() -> [EKEvent]
    {
        print("Loading events")
        
        var eventsToSort = [EKEvent]()
        let calendar = Calendar.current
        let endDate = Date()
        print("Authorisation: \(EKEventStore.authorizationStatus(for: .event) == .fullAccess)")
        
        var eventStore = EKEventStore()
        
        
        
        eventStore.requestFullAccessToEvents
        {(granted,error) in
            if granted
            {
                let calendars = self.eventStore?.calendars(for: .event).filter{$0.title == self.headachesCalendarIdentifier} // Get calendars matching calendarIdentifier
                var calendarNew = self.eventStore?.calendar(withIdentifier: self.headachesCalendarIdentifier)
                print(calendars)
                
                print("Calendars: \(calendars!.count)")
                
                let range:DateComponents = calendar.dateComponents([.day,.month,.year], from: self.startTrackingDate!, to: endDate)
                // Eventkit only accesses the last 4 years to keep performance, therefore need to iterate over 4 year blocks
                if range.year! >= 4
                {
                    print("More than four years since start date")
                    var startDatesOverFourYears = [self.startTrackingDate!]
                    var nextStartDate = calendar.date(byAdding: .year, value: 4, to: self.startTrackingDate!)
                    startDatesOverFourYears.append(nextStartDate!)
                    var newRange = calendar.dateComponents([.day,.month,.year], from: nextStartDate!, to: endDate)
                    
                    // Interates over date range to get start dates for 4 year blocks
                    while newRange.year! >= 4
                    {
                        nextStartDate = calendar.date(byAdding: .year, value: 4, to: startDatesOverFourYears.last!)!
                        startDatesOverFourYears.append(nextStartDate!)
                        newRange = calendar.dateComponents([.day,.month,.year], from: nextStartDate!, to: endDate)
                        
                    }
                    
                    for startDate in startDatesOverFourYears
                    {
                        let events = self.eventStore?.events(matching: self.eventStore!.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)).filter{$0.title == self.eventIdentifier}
                        if events != nil{
                            eventsToSort.append(contentsOf: events!)
                        }
                    }
                    print("Events to sort: \(eventsToSort.count)")
                }
                else
                {
                    print("Less than four years since start date")
                    print("Start date: \(self.startTrackingDate?.description), End date: \(endDate.description), Calendars: \(calendars!.count)")
                    let events = self.eventStore!.events(matching: self.eventStore!.predicateForEvents(withStart: self.startTrackingDate!, end: endDate, calendars: calendars)).filter{$0.title == self.eventIdentifier}
                    print("events: \(events.count)")
                    eventsToSort.append(contentsOf: events)
                }
                
            }
            else
            {
                print("Access To Event Store Denied: \(error)")
            }
            DispatchQueue.main.sync
            {
                if (eventsToSort.count >= 2)
                {
                    self.foundEvents = eventsToSort.sorted{$0.startDate < $1.startDate}
                    print("Events after sort \(self.foundEvents.count)")
                    
                }else
                {
                    self.foundEvents = eventsToSort
                }
                
            }
        }
        
        return foundEvents
    }
    
    */
    
    func loadEventsFromCalendar() async throws -> [EKEvent]
    {
        print("Loading events")
        
        switch EKEventStore.authorizationStatus(for: .event)
        {
        case .denied:
            print("Permissions Denied")
            try await eventStore.requestFullAccessToEvents()
        case.fullAccess:
            print("Full Access Permisssions")
        case .notDetermined:
            print("Permissions Not Determined")
            try await eventStore.requestFullAccessToEvents()
        case.restricted:
            print("Restricted Permissions")
            try await eventStore.requestFullAccessToEvents()
        case.writeOnly:
            print("Write Only Permissions")
            try await eventStore.requestFullAccessToEvents()
        }
        
        
        if EKEventStore.authorizationStatus(for: .event) == .fullAccess
        {
            print("Calendar Access Granted")
            var foundEvents: [EKEvent] = []
            var filteredEvents: [EKEvent] = []
            let currentCalendar = Calendar.current
            let loggingDateRange: DateComponents = currentCalendar.dateComponents([Calendar.Component.day,Calendar.Component.month,Calendar.Component.year], from: startTrackingDate, to: Date())
            print("Years To Process: \(loggingDateRange.year!)")
            let ekStore = EKEventStore()
            print("Auth")
            let calendar = ekStore.calendars(for: .event).filter{$0.title == headachesCalendarIdentifier}
            print("Cals \(calendar.count)")
            
            
            if loggingDateRange.year! > 4
            {
                print("Monitoring Range Over 4 Years")
                
                var rangeCounter = loggingDateRange.year!
                var startDateTracker = startTrackingDate
                var pass = 0
                while rangeCounter > 0
                {
                    print("pass: \(pass)")
                    let endDate = currentCalendar.date(byAdding: .year, value: 4, to: startDateTracker)!
                    
                    let predicate = ekStore.predicateForEvents(withStart: startDateTracker, end: endDate, calendars: calendar)
                    print("Pred \(predicate)")
                    let events = ekStore.events(matching: predicate)
                    print("Eve \(events.count)")
                    foundEvents.append(contentsOf: events)
                    startDateTracker = endDate
                    rangeCounter -= 4
                    pass += 1
                }
                
                filteredEvents.append(contentsOf: foundEvents.filter{$0.title == eventIdentifier})
                
            }else
            {
                
                let predicate = ekStore.predicateForEvents(withStart: startTrackingDate, end: Date(), calendars: calendar)
                print("Pred \(predicate)")
                let foundEvents = ekStore.events(matching: predicate)
                print("Eve \(foundEvents.count)")
                
                filteredEvents.append(contentsOf: foundEvents.filter{$0.title == eventIdentifier})
                print("Filtered Eve \(filteredEvents.count)")
            }
            /*
            let predicate = ekStore.predicateForEvents(withStart: startTrackingDate!, end: Date(), calendars: calendar)
            print("Pred \(predicate)")
            let events = ekStore.events(matching: predicate)
            print("Eve \(events.count)")
            let filteredEvents =  events.filter{$0.title == eventIdentifier}
            print("Filtered Eve \(filteredEvents.count)")
            */
            
            let notes = filteredEvents.map{$0.notes}
            //print(notes)
            let sortedEvents = filteredEvents.sorted{$0.startDate < $1.startDate}
            print(sortedEvents.first)
            return sortedEvents
        }
        print("Failed Due To Calendar Permissions")
        throw NeuratrackError.EventKitImporterErrors.FailedToAccessCalendar
    }
    
    
    
    
    func convertEventKitEventsToHeadacheEvents(foundEventsIn: [EKEvent]) -> [HeadacheEvent]
    {
        print("Converting events")
        var convertedEvents: [HeadacheEvent] = [HeadacheEvent]()
        print(foundEventsIn.first)
        for ekEvent in foundEventsIn
        {
            
            let eventDate = ekEvent.startDate!
            let analgesiaTaken = (ekEvent.notes?.count ?? 0) > 0
            var analgesics: [AnalgesicMedication] = [AnalgesicMedication]()
            var note = ekEvent.notes
            var splitNotes = ekEvent.notes?.split(whereSeparator: \.isNewline)
            
            if analgesiaTaken
            {
                
                var i = 1
                for note in splitNotes!
                {
                    do
                    {
                        analgesics.append(try AnalgesicMedication(name: "Unknown \(i)", dosage: "Unknown", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: nil))
                    }catch
                    {
                        print("failed to create analgesic entry on event kit import")
                    }
                    i += 1
                }
            }
            //convertedEvents.append(HeadacheEvent(date: eventDate, analgesiaTaken: analgesiaTaken,note: note ?? ""))
            convertedEvents.append(HeadacheEvent(date: eventDate, analgesiaTaken: analgesiaTaken, analgesics: [AnalgesicMedication](), note: note ?? ""))
            //convertedEvents.append(HeadacheEvent(date: eventDate, analgesiaTaken: analgesiaTaken, analgesics: analgesics,note: note ?? ""))
        }
        return convertedEvents
    }
    
    func saveToSwiftData() -> Bool
    {
        var didSave = false
        return didSave
    }
    
    
}
