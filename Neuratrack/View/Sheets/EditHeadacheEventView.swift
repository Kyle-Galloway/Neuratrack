//
//  EditHeadacheEventView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 18/01/2024.
//

import SwiftUI
import SwiftData

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
    do
    {
        let med = try AnalgesicMedication(name: "Test", dosage: "Test", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())
        let event = HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [], note: "Test Data")
        return EditHeadacheEventView(event: event)
    }catch
    {
        print(error)
        fatalError("Failed To Create Preview Data")
    }
    
    //EditHeadacheEventView(event: HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [Medication(name: "Paracetamol", dosage: "500 mg", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Test Data"))
}
