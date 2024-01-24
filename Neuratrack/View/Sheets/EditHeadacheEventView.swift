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
    
    @State var event: HeadacheEvent
    //@State var eventDate: Date = Date()
    //@State var eventNotes: String = ""
    //@State var eventAnalgesics: [Medication] //= [Medication(name: "P", dosage: "D", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()),Medication(name: "P2", dosage: "D2", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())]
    
    
    var body: some View {
        NavigationStack
        {
            Form
            {
                
                DatePicker("Date",selection: $event.date).navigationTitle("Edit Event").navigationBarTitleDisplayMode(.inline)
                TextEditor(text: $event.note)
                
                
                
                Section
                {
                    List{AnalgesicListViewItem(analgesic: Medication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()))}
                    List
                    {
                        AnalgesicListViewItem(analgesic: Medication(name: "Paracetamol", dosage: "500 mg", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())).swipeActions(allowsFullSwipe: false)
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
                    }
                    
                    List
                    {
                        /*
                        ForEach(event.analgesics,id: \.id)
                        {analgesic in
                            AnalgesicListViewItem(analgesic: analgesic)
                        }*/
                    }
                    
                } header: {Text("Analgesia")}
                Button("Save")
                {
                    dismissSheet()
                }
            }
        }
    }
}

#Preview {
    
    EditHeadacheEventView(event: HeadacheEvent(date: Date(), analgesiaTaken: true, analgesics: [Medication(name: "Paracetamol", dosage: "500 mg", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Test Data"))
}
