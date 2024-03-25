//
//  AddAnalgesicView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import SwiftData

struct _AddAnalgesicView: View {
    
    @Environment(\.dismiss) var dismissSheet
    @Query var medications: [AnalgesicMedication]
    @State var analgesiaSelection: AnalgesicMedication? = nil
    @State var timeAnalgesicTaken: Date = Date()
    @State var parentHeadacheEvent: HeadacheEvent
    var body: some View {
        NavigationStack
        {
            Form
            {
                Picker("Medication",selection: $analgesiaSelection)
                {
                    ForEach(medications){med in
                        Text(med.name)}
                }
                DatePicker("Time Taken", selection: $timeAnalgesicTaken)
                
            }.navigationTitle("Add Analgesic").toolbar
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
                        print("Save to headache event")
                        //parentHeadacheEvent.analgesics.append(Medication(name: analgesiaSelection?.name ?? "Error", dosage: analgesiaSelection?.dosage ?? "Error", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: timeAnalgesicTaken))
                        dismissSheet()
                    }
                }
            }
        }
    }
}

#Preview {
    let testData = HeadacheEvent(date: Date(), analgesiaTaken: false, note: "")
    //let testData = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [], note: "")
    return AddAnalgesicView(parentHeadacheEvent: testData)
}
