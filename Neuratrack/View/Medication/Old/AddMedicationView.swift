//
//  AddMedicationView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI

struct _AddMedicationView: View {
    
    @State var medicationName: String = ""
    @State var medicationDosage: String = ""
    
    @State var medicationType: MedicationType = .Analgesic
    @State var isPrescription: Bool = false
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
                TextField("Medication Dosage & Instructions", text: $medicationDosage)
                Picker("Type", selection: $medicationType){ForEach(MedicationType.allCases){type in
                    Text(type.rawValue.capitalized)}}
                Toggle(isOn: $isPrescription){ Text("Prescription")}
                if isPrescription
                {
                    DatePicker("Prescription Started", selection: $prescriptionStart,displayedComponents: .date)
                    Toggle(isOn: $isActivePrescription){ Text("Is Active")}
                    if isActivePrescription == false
                    {
                        DatePicker("Prescrition Ended", selection: $prescriptionEnd,displayedComponents: .date)
                    }
                    //DatePicker("Date Taken", selection: $takenDate)
                }
                /*else{
                    DatePicker("Date Taken", selection: $takenDate)
                }*/
            }.navigationTitle("Add Medication").toolbar{ToolbarItem(placement: .cancellationAction)
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
                        
                            print("Adding To Swift Data")
                            
                            switch(medicationType)
                            {
                                case .Analgesic:
                                    do
                                    {
                                        var newMedication: AnalgesicMedication
                                        newMedication = try AnalgesicMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: prescriptionStart, prescriptionStopped: nil, timeTaken: nil)
                                        modelContext.insert(newMedication)
                                    }catch
                                    {
                                        print("Error creating new analgesic medication data")
                                    }
                                case .Prophylactic:
                                    do
                                    {
                                        var newMedication: ProphylacticMedication
                                        newMedication = try ProphylacticMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: takenDate)
                                        modelContext.insert(newMedication)
                                    }catch
                                    {
                                        print("Error creating new prophylactic medication data")
                                    }
                                case .Other:
                                    do
                                    {
                                        var newMedication: OtherMedication
                                        newMedication = try OtherMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: takenDate)
                                        modelContext.insert(newMedication)
                                    }catch
                                    {
                                        print("Error creating new other medication data")
                                    }
                                default:
                                    print("Error creating medication data")
                            }
                            /*
                            if medicationType == .Analgesic
                            {
                                do{
                                    var newMedication: AnalgesicMedication
                                    newMedication = try AnalgesicMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: prescriptionStart, prescriptionStopped: nil, timeTaken: nil)
                                    modelContext.insert(newMedication)}catch{
                                        print("Error creating new analgesic medication data")
                                    }
                            }else
                            {
                                if medicationType == .Prophylactic
                                {
                                    do{
                                    var newMedication: ProphylacticMedication
                                    newMedication = try ProphylacticMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: takenDate)
                                    modelContext.insert(newMedication)}catch{
                                        print("Error creating new prophylactic medication data")
                                    }
                                }else
                                {
                                    do{
                                    var newMedication: OtherMedication
                                    newMedication = try OtherMedication(name: medicationName, dosage: medicationDosage, type: medicationType, isActivePrescription: isActivePrescription, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: takenDate)
                                    modelContext.insert(newMedication)}catch{
                                        print("Error creating new other medication data")
                                    }
                                }
                            }*/
                            
                            dismissSheet()
                    }
                }
            }
        }
    }
}

#Preview {
    AddMedicationView()
}
