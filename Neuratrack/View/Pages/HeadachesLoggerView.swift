//
//  HeadachesLoggerView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import EventKitUI
import SwiftData

struct HeadachesLoggerView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \HeadacheEvent.date) var headacheEvents: [HeadacheEvent] //= [HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil)] //= ["Headache"] // TODO: change type to array of headache events
    
    //var testHeadacheEventList: [HeadacheEvent] //= [HeadacheEvent](repeating: HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil), count: 100)
    
    @State var presentAddHeadacheSheet: Bool = false
    @State var presentEditHeadacheSheet: Bool = false
    
    @State var yearsInData: [Int] = []
    var calendar: Calendar = Calendar.current
    
    init()
    {
        self.calendar = Calendar.current

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
                                HeadacheEventListViewItem(entry: contentEntry)
                                /*
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
                                        modelContext.delete(contentEntry)
                                    } label: {
                                        Label("Delete",systemImage: "trash")
                                    }
                                }*/
                            }
                        }
                    }
                }
                
                /*
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
                }*/
                
            }.navigationTitle("Headache Logger")
            .toolbar
            {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button("Add Medication", systemImage: "plus")
                    {
                        presentAddHeadacheSheet.toggle()
                        print("Show add headache screen")
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
            .listStyle(.insetGrouped)
            .sheet(isPresented: $presentAddHeadacheSheet)
            {
                AddHeadacheEventView()
            }
        }.onAppear
            {
                print("HeadachesLoggerView Appeared")
                self.yearsInData = headacheEvents.yearsInArray()
                print("*** add years to array ***")
            }
            .onChange(of: headacheEvents)
            {
                print("Headache Events Array Changed")
                self.yearsInData = headacheEvents.yearsInArray()
            }.overlay{
                if headacheEvents.isEmpty
                {
                    VStack{
                        Image(systemName: "exclamationmark.arrow.triangle.2.circlepath").dynamicTypeSize(.accessibility5)
                        Text("No Data")}
                }
            }
    }
}

#Preview {
    
    
    do
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HeadacheEvent.self,configurations: config)
        
        let example = HeadacheEvent(date: Date(), analgesiaTaken: true, note: "Test Data")
        //let example = HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [Medication(name: "Test Medi", dosage: "Test Dose", type: MedicationType.Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Test Data")
        return HeadachesLoggerView().modelContainer(container)
        
    }catch
    {
        fatalError("Failed to create model container for preview")
    }
    
    //HeadachesLoggerView(headacheEvents: [HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil)], testHeadacheEventList: [HeadacheEvent](repeating: HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil), count: 100), presentAddHeadacheSheet: false)
}
