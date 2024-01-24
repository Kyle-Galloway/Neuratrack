//
//  AnalgesicListViewItem.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 18/01/2024.
//

import SwiftUI

struct AnalgesicListViewItem: View {
    @State var analgesic: Medication
    var body: some View {
        HStack{
            Text("\(analgesic.name)")
            Text("\(analgesic.dosage)")
            Text("\(analgesic.timeTaken!.formatted())")
        }
    }
}

#Preview {
    
    AnalgesicListViewItem(analgesic: Medication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()))
}
