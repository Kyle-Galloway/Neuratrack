//
//  MedicationManagementView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import SwiftUI
import SwiftData

struct _MedicationManagementView: View
{
    //@Query var medications: [Medication]
    @Query var analgesics: [AnalgesicMedication]
    @Query var prophylactics: [ProphylacticMedication]
    @Query var others: [OtherMedication]
    /*
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Analgesic.rawValue}) var analgesics: [Medication]
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Prophylactic.rawValue}) var prophylactics: [Medication]
    @Query(filter: #Predicate<Medication>{med in
        med.type.rawValue == MedicationType.Other.rawValue}) var others: [Medication]
    */
    
    /*
    @Query var medications: [Medication]
    @Query var analgesics: [Medication]
    @Query var prophylactics: [Medication]
    @Query var others: [Medication]
     */
    
    
    //var medications: [Medication]
    /*
    @State var analgesics: [Medication] = []
    @State var prophylactics: [Medication] = []
    @State var others: [Medication] = []
    */
    @State private var presentAddMedicationSheet: Bool = false
    
    init()
    {
        /*
        let analgesicFilterValue = MedicationType.Analgesic.rawValue
        let analgesicFilter = #Predicate<Medication>{med in
            med.type.rawValue == analgesicFilterValue}
        _analgesics = Query(filter: analgesicFilter)
        
        let prophylacticFilterValue = MedicationType.Prophylactic.rawValue
        let prophylacticFiler = #Predicate<Medication>{med in
            med.type.rawValue == prophylacticFilterValue}
        _prophylactics = Query(filter: prophylacticFiler)
        
        let otherFilterValue = MedicationType.Other.rawValue
        let otherFilter = #Predicate<Medication>{med in
            med.type.rawValue == otherFilterValue}
        _others = Query(filter: otherFilter)
         */
        /*
        let analgesicFilterValue = MedicationType.Analgesic.rawValue
        let analgesicFilter = #Predicate<Medication>{med in
            med.rawTypeValue == analgesicFilterValue}
        _analgesics = Query(filter: analgesicFilter)
        
        let prophylacticFilterValue = MedicationType.Prophylactic.rawValue
        let prophylacticFiler = #Predicate<Medication>{med in
            med.rawTypeValue == prophylacticFilterValue}
        _prophylactics = Query(filter: prophylacticFiler)
        
        let otherFilterValue = MedicationType.Other.rawValue
        let otherFilter = #Predicate<Medication>{med in
            med.rawTypeValue == otherFilterValue}
        _others = Query(filter: otherFilter)
        */
        /*
        medications = []
        analgesics = []
        prophylactics = []
        others = []
        */
    }
    
    
    var body: some View 
    {
        NavigationStack
        {
            List
            {
                /*
                Section
                {
                    ForEach(medications,id:\.self)
                    {med in
                        HStack
                        {
                            Text(med.name)
                            Text(med.dosage)
                        }
                    }.onDelete(perform: { indexSet in
                        print("Remove from swiftdata")
                    })
                } header:
                {
                    Text("All Medications")
                }
                */
                Section
                {
                    ForEach(analgesics,id:\.self)
                    {analgesic in
                        HStack
                        {
                            Text(analgesic.name)
                            Text(analgesic.dosage)
                        }
                    }.onDelete(perform: { indexSet in
                        print("TODO: Remove analgesic from swiftdata")
                    })
                    
                } header:
                {
                    Text("Analgesic Medications")
                }
                
                Section
                {
                    ForEach(prophylactics,id:\.self)
                    {prophylactic in
                        HStack
                        {
                            Text(prophylactic.name)
                            Text(prophylactic.dosage)
                        }
                    }.onDelete(perform: { indexSet in
                        print("TODO: Remove prophylactic from swiftdata")
                    })
                    
                } header:
                {
                    Text("Prohylactic Medications")
                }
                
                Section{
                    ForEach(others, id:\.self)
                    {other in
                        HStack
                        {
                            Text(other.name)
                            Text(other.dosage)
                        }
                    }.onDelete
                    {indexSet in
                        print("TODO: Remove other from swiftdata")
                    }
                } header:
                {
                    Text("Other Medications")
                }
                /**/
            }.navigationTitle("Manage Medications")
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
                .sheet(isPresented: $presentAddMedicationSheet){
                    AddMedicationView()
                }
        }.onAppear
        {
            print("MedicationManagementView Appeared")
            print("Medications loaded from swiftdata A: \(analgesics.count), P: \(prophylactics.count), O: \(others.count)")
            //print("Medications Loaded From SwiftData: \(medications.count)")
            
            /*
             analgesics = medications.filter{$0.type == .Analgesic}
             prophylactics = medications.filter{$0.type == .Prophylactic}
             others = medications.filter{$0.type == .Other}*/
            
            
        }
        
        
    }
    
}

#Preview {
    MedicationManagementView()
}
