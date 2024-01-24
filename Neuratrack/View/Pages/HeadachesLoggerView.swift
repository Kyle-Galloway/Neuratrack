//
//  HeadachesLoggerView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import EventKitUI

struct HeadachesLoggerView: View {
    var headacheEvents: [HeadacheEvent] //= [HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil)] //= ["Headache"] // TODO: change type to array of headache events
    
    var testHeadacheEventList: [HeadacheEvent] //= [HeadacheEvent](repeating: HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil), count: 100)
    
    @State var presentAddHeadacheSheet: Bool = false
    @State var presentEditHeadacheSheet: Bool = false
    
    var yearsInData: [Int]
    var testData: [HeadacheEvent]
    var calendar: Calendar
    
    init(headacheEvents: [HeadacheEvent], testHeadacheEventList: [HeadacheEvent], presentAddHeadacheSheet: Bool) {
        self.headacheEvents = headacheEvents
        self.testHeadacheEventList = testHeadacheEventList
        //self.presentAddHeadacheSheet = presentAddHeadacheSheet
        self.calendar = Calendar.current
        self.yearsInData = Array(Set(headacheEvents.map{Calendar.current.component(.year, from: $0.date)})).sorted().reversed()
        print(yearsInData)
        do
        {
            self.testData = [HeadacheEvent(date: try Date("2021-01-01T12:30:00Z",strategy: .iso8601), analgesiaTaken: false, analgesics: nil, note: nil),HeadacheEvent(date: try Date("2022-02-02T12:40:00Z",strategy:.iso8601), analgesiaTaken: false, analgesics: nil, note: nil),HeadacheEvent(date: try Date("2022-02-03T12:40:00Z",strategy:.iso8601), analgesiaTaken: false, analgesics: nil, note: nil)]
            
        }catch
        {
            print("Error generating test data")
            self.testData = []
        }
        
    }
    
    var body: some View {
        NavigationStack
        {
            List
            {
                ForEach(yearsInData,id:\.self)
                {year in
                    var disclouseGroupContent = headacheEvents.filter{calendar.component(.year, from: $0.date) == year}
                    if disclouseGroupContent.count != 0
                    {
                        DisclosureGroup(String(year))
                        {
                            ForEach(disclouseGroupContent,id:\.self)
                            {contentEntry in
                                
                                HStack
                                {
                                    Text(contentEntry.date.formatted())
                                    Spacer()
                                    //Change to read contents of note and analgesics
                                    if contentEntry.analgesiaTaken && contentEntry.note.isEmpty == false
                                    {
                                        Image(systemName: "pill.fill").foregroundColor(.green)
                                        Image(systemName: "note.text").foregroundColor(.green)
                                    }else if contentEntry.analgesiaTaken && contentEntry.note.isEmpty
                                    {
                                        Image(systemName: "pill.fill").foregroundColor(.green)
                                        Image(systemName: "note.text").foregroundColor(.gray)
                                    }else if contentEntry.analgesiaTaken == false && contentEntry.note.isEmpty == false
                                    {
                                        Image(systemName: "pill.fill").foregroundColor(.gray)
                                        Image(systemName: "note.text").foregroundColor(.green)
                                    }else if contentEntry.analgesiaTaken == false && contentEntry.note.isEmpty
                                    {
                                        Image(systemName: "pill.fill").foregroundColor(.gray)
                                        Image(systemName: "note.text").foregroundColor(.gray)
                                    }
                                    
                                }.swipeActions(allowsFullSwipe: false)
                                {
                                    Button
                                    {
                                        print("Editing Event")
                                    }label: {
                                        Label("Edit",systemImage: "pencil")
                                    }.tint(.indigo)
                                    Button(role:.destructive)
                                    {
                                        print("Deleting Event")
                                    } label: {
                                        Label("Delete",systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                ForEach(testHeadacheEventList,id:\.self)
                {event in
                    HStack
                    {
                        Text(event.date.formatted())
                        Spacer()
                        //Change to read contents of note and analgesics
                        if event.analgesiaTaken && event.note.isEmpty == false
                        {
                            Image(systemName: "pill.fill").foregroundColor(.green)
                            Image(systemName: "note.text").foregroundColor(.green)
                        }else if event.analgesiaTaken && event.note.isEmpty
                        {
                            Image(systemName: "pill.fill").foregroundColor(.green)
                            Image(systemName: "note.text").foregroundColor(.gray)
                        }else if event.analgesiaTaken == false && event.note.isEmpty == false
                        {
                            Image(systemName: "pill.fill").foregroundColor(.gray)
                            Image(systemName: "note.text").foregroundColor(.green)
                        }else if event.analgesiaTaken == false && event.note.isEmpty
                        {
                            Image(systemName: "pill.fill").foregroundColor(.gray)
                            Image(systemName: "note.text").foregroundColor(.gray)
                        }
                        
                    }.swipeActions(allowsFullSwipe: false)
                    {
                        Button
                        {
                            print("Editing Event")
                        } label: {
                            Label("Edit",systemImage: "pencil")
                        }.tint(.indigo)
                        Button(role:.destructive)
                        {
                            print("Deleting Event")
                        } label: {
                            Label("Delete",systemImage: "trash")
                        }
                    }
                }
                
            }.navigationTitle("Headache Logger").toolbar
            {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button("Add Medication", systemImage: "plus")
                    {
                        presentAddHeadacheSheet.toggle()
                        print("Show add headache screen")
                    }
                }
            }.navigationBarTitleDisplayMode(.inline).listStyle(.insetGrouped)
                .sheet(isPresented: $presentAddHeadacheSheet){
                    AddHeadacheEventView()
                }
        }
    }
}

#Preview {
    
    HeadachesLoggerView(headacheEvents: [HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil)], testHeadacheEventList: [HeadacheEvent](repeating: HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil), count: 100), presentAddHeadacheSheet: false)
}
