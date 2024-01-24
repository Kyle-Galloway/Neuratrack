//
//  Medication.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import Foundation
import SwiftData

enum MedicationType: String, CaseIterable, Identifiable, Codable, Hashable
{
    case Analgesic
    case Prophylactic
    case Other
    
    var id: Self{self}
}

@Model
class Medication: Identifiable
{
    
    var id: UUID
    var name: String
    var dosage: String
    var type: MedicationType
    var isActivePrescription: Bool
    var prescriptionStarted: Date?
    var prescriptionStopped: Date?
    var timeTaken: Date?
    
    
    init(id: UUID = UUID(), name: String, dosage: String, type: MedicationType, isActivePrescription: Bool ,prescriptionStarted: Date?, prescriptionStopped: Date?, timeTaken: Date?) {
        self.id = id
        self.name = name
        self.dosage = dosage
        self.type = type
        self.isActivePrescription = isActivePrescription
        
        if type != .Analgesic
        {
            self.prescriptionStarted = prescriptionStarted
            if isActivePrescription == false
            {
                self.prescriptionStopped = prescriptionStopped
            }else
            {
                self.prescriptionStopped = nil
            }
        }else
        {
            self.timeTaken = timeTaken
        }
    }
}
