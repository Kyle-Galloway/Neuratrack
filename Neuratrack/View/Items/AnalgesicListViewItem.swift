//
//  AnalgesicListViewItem.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 18/01/2024.
//

import SwiftUI

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

#Preview {
    do
    {
        return AnalgesicListViewItem(analgesic: try AnalgesicMedication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date()))
    }
    catch
    {
        fatalError("Failed to create data for preview")
    }
}
