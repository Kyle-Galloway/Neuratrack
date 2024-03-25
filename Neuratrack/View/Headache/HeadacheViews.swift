//
//  HeadacheViews.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/02/2024.
//

import SwiftUI
import SwiftData

struct AddHeadacheEventView: View {
    
    @Environment(\.dismiss) var dismissSheet
    @Environment(\.modelContext) var modelContext
    
    @State var isAddAnalgesiaSheetPresented: Bool = false
    
    @State var eventNotes: String = ""
    
    @State var analgesics: [AnalgesicMedication] = []
    
    @State var headacheTime: Date = Date()
    
    @State var newEvent: HeadacheEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, note: "")
    //@State var newEvent: HeadacheEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [], note: "")
    var body: some View {
        NavigationStack
        {
            Form
            {
                DatePicker("Date", selection: $headacheTime).navigationBarTitleDisplayMode(.inline)
                Section
                {
                    List{}
                } header: {Text("Analgesia")}
                
                Button("Add Analgesic")
                {
                    isAddAnalgesiaSheetPresented.toggle()
                }
                Section
                {
                    TextEditor(text: $eventNotes)
                } header:{Text("Notes")}
                
            }.navigationTitle("Add Headache").sheet(isPresented: $isAddAnalgesiaSheetPresented) {
                AddAnalgesicView(parentHeadacheEvent: newEvent)
            }.toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cancel")
                    {
                        dismissSheet()
                    }
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Add")
                    {
                        let newEvent = HeadacheEvent(date: headacheTime, analgesiaTaken: analgesics.count > 0, note: eventNotes)
                        //let newEvent = HeadacheEvent(date: headacheTime, analgesiaTaken: analgesics.count > 0, analgesics: analgesics, note: eventNotes)
                        modelContext.insert(newEvent)
                        dismissSheet()
                    }
                }
            }
        }
    }
}

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

struct HeadacheEventListViewItem: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var entry: HeadacheEvent
    @State var isEditEventSheetPresented: Bool = false
    @State var isViewEventInfoPopoverPresented: Bool = false
    
    var body: some View {
        HStack
        {
            Text(entry.date.formatted())
            Spacer()
            
            //Change to read contents of note and analgesics
            if entry.analgesiaTaken && entry.note.isEmpty == false
            {
                Image(systemName: "pill.fill").foregroundColor(.green)
                Image(systemName: "note.text").foregroundColor(.green)
            }else if entry.analgesiaTaken && entry.note.isEmpty
            {
                Image(systemName: "pill.fill").foregroundColor(.green)
                Image(systemName: "note.text").foregroundColor(.gray)
            }else if entry.analgesiaTaken == false && entry.note.isEmpty == false
            {
                Image(systemName: "pill.fill").foregroundColor(.gray)
                Image(systemName: "note.text").foregroundColor(.green)
            }else if entry.analgesiaTaken == false && entry.note.isEmpty
            {
                Image(systemName: "pill.fill").foregroundColor(.gray)
                Image(systemName: "note.text").foregroundColor(.gray)
            }
            
        }.swipeActions(allowsFullSwipe: false)
        {
            Button
            {
                print("Editing Event")
                isEditEventSheetPresented = true
            }label: {
                Label("Edit",systemImage: "pencil")
            }.tint(.indigo)
            Button(role:.destructive)
            {
                print("Deleting Event")
                modelContext.delete(entry)
            } label: {
                Label("Delete",systemImage: "trash")
            }
        }.onTapGesture {
            isViewEventInfoPopoverPresented.toggle()
        }.sheet(isPresented: $isEditEventSheetPresented)
        {
            EditHeadacheEventView(event: entry)
        }.popover(isPresented: $isViewEventInfoPopoverPresented, content: {
            Text("\(entry.date.formatted()) \(entry.analgesics.count)")
            Text("\(entry.note)")
        })
    }
}

struct EditHeadacheEventView: View {
    
    @Environment(\.dismiss) var dismissSheet
    
    @Bindable var event: HeadacheEvent
    @State var isAddAnalgesicSheetPresented: Bool = false
    @State var originalEvent: HeadacheEvent
    //@State var eventDate: Date = Date()
    //@State var eventNotes: String = ""
    //@State var eventAnalgesics: [Medication] //= [Medication(name: "P", dosage: "D", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()),Medication(name: "P2", dosage: "D2", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())]
    init(event parentEvent: HeadacheEvent)
    {
        event = parentEvent
        _originalEvent = State(initialValue: parentEvent.copy() as! HeadacheEvent)
    }
    
    
    var body: some View {
        NavigationStack
        {
            Form
            {
                
                DatePicker("Date",selection: $event.date).navigationTitle("Edit Event").navigationBarTitleDisplayMode(.inline)
                TextEditor(text: $event.note)
                
                
                
                Section
                {
                    /*
                    List{AnalgesicListViewItem(analgesic: AnalgesicMedication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()))}
                    List
                    {
                        AnalgesicListViewItem(analgesic: AnalgesicMedication(name: "Paracetamol", dosage: "500 mg", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())).swipeActions(allowsFullSwipe: false)
                        {Button
                            {
                                print("Editing Headache Analgesic")
                            } label: {
                                Label("Edit",systemImage: "pencil")
                            }.tint(.indigo)
                            Button(role:.destructive)
                            {
                                print("Deleting Headache Analgesic")
                            } label: {
                                Label("Delete",systemImage: "trash")
                            }}
                    }*/
                    
                    List
                    {
                        Button("Add Analgesic")
                        {
                            isAddAnalgesicSheetPresented = true
                        }
                        ForEach(event.analgesics,id: \.id)
                        {analgesic in
                            
                            AnalgesicListViewItem(analgesic: analgesic)
                        }.onDelete
                        {indexSet in
                            event.analgesics.remove(atOffsets: indexSet)
                        }
                    }
                    
                } header: {Text("Analgesia")}
                
            }.sheet(isPresented: $isAddAnalgesicSheetPresented)
            {
                AddAnalgesicView(parentHeadacheEvent: event)
            }.toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cancel",role: .cancel)
                    {
                        print("Current: \(event), Original: \(originalEvent)")
                        event.date = originalEvent.date
                        event.analgesiaTaken = originalEvent.analgesiaTaken
                        event.analgesics = originalEvent.analgesics
                        event.note = originalEvent.note
                        dismissSheet()
                    }
                }
                ToolbarItem(placement: .primaryAction)
                {
                    Button("Save")
                    {
                        dismissSheet()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHeadacheEventView().previewDevice("Add Headache Event")
}

#Preview {
    
    
    do
    {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HeadacheEvent.self,configurations: config)
        
        let example = HeadacheEvent(date: Date(), analgesiaTaken: true, note: "Test Data")
        //let example = HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [Medication(name: "Test Medi", dosage: "Test Dose", type: MedicationType.Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Test Data")
        return HeadachesLoggerView().modelContainer(container).previewDisplayName("Headache Logger")
        
    }catch
    {
        fatalError("Failed to create model container for preview")
    }
    
    //HeadachesLoggerView(headacheEvents: [HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil)], testHeadacheEventList: [HeadacheEvent](repeating: HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: nil, note: nil), count: 100), presentAddHeadacheSheet: false)
}

#Preview {
    do
    {
        let med = try AnalgesicMedication(name: "Test", dosage: "Test", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())
        let event = HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [], note: "Test Data")
        return EditHeadacheEventView(event: event).previewDisplayName("Edit Headache Event")
    }catch
    {
        print(error)
        fatalError("Failed To Create Preview Data")
    }
    
    //EditHeadacheEventView(event: HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [Medication(name: "Paracetamol", dosage: "500 mg", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Test Data"))
}

#Preview {
    do{
        let entry = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [try AnalgesicMedication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Note")
        return HeadacheEventListViewItem(entry: entry).previewDisplayName("Headache Event List Item")
    }catch
    {
        fatalError("Failed to create data for preview")
    }
}
