//
//  MedicationViews.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/02/2024.
//

import SwiftUI
import SwiftData


struct MedicationManagementView: View{
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

struct AddMedicationView: View {
    
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

struct AddAnalgesicView: View {
    
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

struct AnalgesicListViewItem: View {
    @State var analgesic: AnalgesicMedication
    var body: some View {
        HStack{
            Text("\(analgesic.name)")
            Text("\(analgesic.dosage)")
            Text("\(analgesic.timeTaken!.formatted())")
        }
    }
}


#Preview{
    
    return MedicationManagementView().previewDevice("Medication Management")
    
}

#Preview{
    do
    {
        return AnalgesicListViewItem(analgesic: try AnalgesicMedication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())).previewDisplayName("Analgesic List Item")
            
        
    }
    catch
    {
        fatalError("Failed to create data for preview")
    }
    
}

#Preview{
    let testData = HeadacheEvent(date: Date(), analgesiaTaken: false, note: "")
                //let testData = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [], note: "")
    return AddAnalgesicView(parentHeadacheEvent: testData).previewDisplayName("Add Analgesic")
}

#Preview{
    return AddMedicationView().previewDisplayName("Add Medication")
}
