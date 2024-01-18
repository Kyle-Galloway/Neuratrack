//
//  MedicationManagementView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI
import SwiftData

struct MedicationManagementView: View
{
    /*
    
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Analgesic.rawValue}) var analgesics: [Medication]
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Prophylactic.rawValue}) var prophylactics: [Medication]
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Other.rawValue}) var others: [Medication]
    */
    
    @Query var medications: [Medication]
    @Query var analgesics: [Medication]
    @Query var prophylactics: [Medication]
    @Query var others: [Medication]
    
    @State private var presentAddMedicationSheet: Bool = false
    
    init()
    {
        let analgesicFilter = MedicationType.Analgesic.rawValue
        _analgesics = Query(filter: #Predicate<Medication>{med in
            med.type.rawValue == analgesicFilter})
        
        let prophylacticFilter = MedicationType.Prophylactic.rawValue
        _prophylactics = Query(filter: #Predicate<Medication>{med in
            med.type.rawValue == prophylacticFilter})
        
        let otherFilter = MedicationType.Other.rawValue
        _others = Query(filter: #Predicate<Medication>{med in
            med.type.rawValue == otherFilter})
    }
    
    
    var body: some View 
    {
        NavigationStack
        {
            List
            {
                Section
                {
                    List
                    {   ForEach(analgesics,id:\.self)
                        {analgesic in
                            HStack
                            {
                                Text(analgesic.name)
                                Text(analgesic.dosage)
                            }
                        }.onDelete(perform: { indexSet in
                            print("Remove from swiftdata")
                        })
                    }
                } header:
                {
                    Text("Analgesic Medications")
                }
                
                Section
                {
                    List
                    {   ForEach(prophylactics,id:\.self)
                        {prophylactic in
                            HStack
                            {
                                Text(prophylactic.name)
                                Text(prophylactic.dosage)
                            }
                        }.onDelete(perform: { indexSet in
                            print("Remove from swiftdata")
                        })
                    }
                } header:
                {
                    Text("Prohylactic Medications")
                }
                
                Section{
                    List
                    {
                        ForEach(others, id:\.self)
                        {other in
                            HStack
                            {
                                Text(other.name)
                                Text(other.dosage)
                            }
                        }.onDelete
                        {indexSet in
                            print("Remove from swiftdata")
                        }
                    }
                } header:
                {
                    Text("Other Medications")
                }
            }.navigationTitle("Medications")
                .toolbar
                {
                    ToolbarItem(placement: .topBarTrailing)
                    {
                        Button("Add Medication", systemImage: "plus")
                        {
                            presentAddMedicationSheet.toggle()
                            print("Show add medication screen")
                        }
                    }
                }.navigationBarTitleDisplayMode(.inline).listStyle(.insetGrouped)
                    .sheet(isPresented: $presentAddMedicationSheet)
            {
                AddMedicationView()
            }
        }
    }
}

#Preview {
    MedicationManagementView()
}
