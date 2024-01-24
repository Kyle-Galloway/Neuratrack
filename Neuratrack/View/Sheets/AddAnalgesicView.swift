//
//  AddAnalgesicView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import SwiftData

struct AddAnalgesicView: View {
    
    @Environment(\.dismiss) var dismissSheet
    @Query var medications: [Medication]
    @State var analgesiaSelection: Medication? = nil
    @State var timeAnalgesicTaken: Date = Date()
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
                Button("Add")
                {
                    print("Save to headache event")
                    dismissSheet()
                }
            }.navigationTitle("Add Analgesic")
        }
    }
}

#Preview {
    AddAnalgesicView()
}
