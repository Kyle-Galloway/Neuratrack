//
//  AddMedicationView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI

struct AddMedicationView: View {
    
    @State var medicationName: String = ""
    @State var medicationDosage: String = ""
    
    @State var medicationType: MedicationType = .Analgesic
    @State var isActivePrescription: Bool = false
    @State var prescriptionStart: Date = Date()
    @State var prescriptionEnd: Date = Date()
    @State var takenDate: Date = Date()
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismissSheet
    
    var body: some View {
        NavigationStack{
            Form
            {
                TextField("Medication Name", text: $medicationName)
                TextField("Medication Dosage", text: $medicationDosage)
                Picker("Type", selection: $medicationType){ForEach(MedicationType.allCases){type in
                    Text(type.rawValue.capitalized)}}
                
                if medicationType != .Analgesic
                {
                    DatePicker("Prescrition Started", selection: $prescriptionStart,displayedComponents: .date)
                    Toggle(isOn: $isActivePrescription){ Text("Is Active")}
                    if isActivePrescription == false
                    {
                        DatePicker("Prescrition Ended", selection: $prescriptionEnd,displayedComponents: .date)
                    }
                }else{
                    DatePicker("Date Taken", selection: $takenDate)
                }
                Button("Add Medication")
                {
                    print("Add To Swift Data")
                    var newMedication: Medication
                    if isActivePrescription && medicationType != .Analgesic
                    {
                        newMedication = Medication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: prescriptionStart, prescriptionStopped: nil, timeTaken: nil)
                    }else
                    {
                        newMedication = Medication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: takenDate)
                    }
                    
                    modelContext.insert(newMedication)
                    dismissSheet()
                }
            }.navigationTitle("Add Medication")
        }
    }
}

#Preview {
    AddMedicationView()
}
