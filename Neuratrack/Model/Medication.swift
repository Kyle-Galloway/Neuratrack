//
//  Medication.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import Foundation
import SwiftData

enum MedicationErrors: Error
{
    case MedicationTypeError
}

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
    var rawTypeValue: String
    var isActivePrescription: Bool
    var prescriptionStarted: Date?
    var prescriptionStopped: Date?
    var timeTaken: Date?
    
    /* original init
    init(id: UUID = UUID(), name: String, dosage: String, type: MedicationType, isActivePrescription: Bool ,prescriptionStarted: Date?, prescriptionStopped: Date?, timeTaken: Date?) throws
    {
        self.id = id
        self.name = name
        self.dosage = dosage
        //self.type = type Removed for work around
        //self.rawTypeValue = type.rawValue Removed for work around
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
    }*/
    
    init(_ subClass: AnalgesicMedication)
    {
        self.id = subClass.id
        self.name = subClass.name
        self.dosage = subClass.dosage
        self.type = subClass.type
        self.rawTypeValue = subClass.rawTypeValue
        self.isActivePrescription = subClass.isActivePrescription
        self.prescriptionStarted = subClass.prescriptionStarted
        self.prescriptionStopped = subClass.prescriptionStopped
        self.timeTaken = subClass.timeTaken
    }
    
    init(_ subClass: ProphylacticMedication)
    {
        self.id = subClass.id
        self.name = subClass.name
        self.dosage = subClass.dosage
        self.type = subClass.type
        self.rawTypeValue = subClass.rawTypeValue
        self.isActivePrescription = subClass.isActivePrescription
        self.prescriptionStarted = subClass.prescriptionStarted
        self.prescriptionStopped = subClass.prescriptionStopped
        self.timeTaken = subClass.timeTaken
    }
    init(_ subClass: OtherMedication)
    {
        self.id = subClass.id
        self.name = subClass.name
        self.dosage = subClass.dosage
        self.type = subClass.type
        self.rawTypeValue = subClass.rawTypeValue
        self.isActivePrescription = subClass.isActivePrescription
        self.prescriptionStarted = subClass.prescriptionStarted
        self.prescriptionStopped = subClass.prescriptionStopped
        self.timeTaken = subClass.timeTaken
    }
}

// Workaround for swiftdata being unable to filter by enum

@Model
class AnalgesicMedication: Identifiable, Codable, CustomStringConvertible
{
    
    var id: UUID
    var name: String
    var dosage: String
    var type: MedicationType
    var rawTypeValue: String
    var isActivePrescription: Bool
    var prescriptionStarted: Date?
    var prescriptionStopped: Date?
    var timeTaken: Date?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dosage = try container.decode(String.self, forKey: .dosage)
        self.type = try container.decode(MedicationType.self, forKey: .type)
        self.rawTypeValue = try container.decode(String.self, forKey: .rawTypeValue)
        self.isActivePrescription = try container.decode(Bool.self, forKey: .isActivePrescription)
        self.prescriptionStarted = try container.decodeIfPresent(Date.self, forKey: .prescriptionStarted)
        self.prescriptionStopped = try container.decodeIfPresent(Date.self, forKey: .prescriptionStopped)
        self.timeTaken = try container.decodeIfPresent(Date.self, forKey: .timeTaken)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case dosage
        case type
        case rawTypeValue
        case isActivePrescription
        case prescriptionStarted
        case prescriptionStopped
        case timeTaken
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.dosage, forKey: .dosage)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.rawTypeValue, forKey: .rawTypeValue)
        try container.encode(self.isActivePrescription, forKey: .isActivePrescription)
        try container.encodeIfPresent(self.prescriptionStarted, forKey: .prescriptionStarted)
        try container.encodeIfPresent(self.prescriptionStopped, forKey: .prescriptionStopped)
        try container.encodeIfPresent(self.timeTaken, forKey: .timeTaken)
    }
    
    init(id: UUID = UUID(), name: String, dosage: String, type: MedicationType, isActivePrescription: Bool ,prescriptionStarted: Date?, prescriptionStopped: Date?, timeTaken: Date?) throws
    {
        if type != .Analgesic
        {
            throw MedicationErrors.MedicationTypeError
        }
        
        self.id = id
        self.name = name
        self.dosage = dosage
        self.type = MedicationType.Analgesic
        self.rawTypeValue = MedicationType.Analgesic.rawValue
        self.isActivePrescription = isActivePrescription
        self.prescriptionStarted = prescriptionStarted
        self.prescriptionStopped = prescriptionStopped
        self.timeTaken = timeTaken
    
    }
}


@Model
class ProphylacticMedication: Identifiable, Codable, CustomStringConvertible
{
    var id: UUID
    var name: String
    var dosage: String
    var type: MedicationType
    var rawTypeValue: String
    var isActivePrescription: Bool
    var prescriptionStarted: Date?
    var prescriptionStopped: Date?
    var timeTaken: Date?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dosage = try container.decode(String.self, forKey: .dosage)
        self.type = try container.decode(MedicationType.self, forKey: .type)
        self.rawTypeValue = try container.decode(String.self, forKey: .rawTypeValue)
        self.isActivePrescription = try container.decode(Bool.self, forKey: .isActivePrescription)
        self.prescriptionStarted = try container.decodeIfPresent(Date.self, forKey: .prescriptionStarted)
        self.prescriptionStopped = try container.decodeIfPresent(Date.self, forKey: .prescriptionStopped)
        self.timeTaken = try container.decodeIfPresent(Date.self, forKey: .timeTaken)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case dosage
        case type
        case rawTypeValue
        case isActivePrescription
        case prescriptionStarted
        case prescriptionStopped
        case timeTaken
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.dosage, forKey: .dosage)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.rawTypeValue, forKey: .rawTypeValue)
        try container.encode(self.isActivePrescription, forKey: .isActivePrescription)
        try container.encodeIfPresent(self.prescriptionStarted, forKey: .prescriptionStarted)
        try container.encodeIfPresent(self.prescriptionStopped, forKey: .prescriptionStopped)
        try container.encodeIfPresent(self.timeTaken, forKey: .timeTaken)
    }
    
    init(id: UUID = UUID(), name: String, dosage: String, type: MedicationType, isActivePrescription: Bool ,prescriptionStarted: Date?, prescriptionStopped: Date?, timeTaken: Date?) throws
    {
        if type != .Prophylactic
        {
            throw MedicationErrors.MedicationTypeError
        }
        
        self.id = id
        self.name = name
        self.dosage = dosage
        self.type = MedicationType.Analgesic
        self.rawTypeValue = MedicationType.Analgesic.rawValue
        self.isActivePrescription = isActivePrescription
        self.prescriptionStarted = prescriptionStarted
        self.prescriptionStopped = prescriptionStopped
        self.timeTaken = timeTaken
        
        
    }
}
@Model
class OtherMedication: Identifiable, Codable, CustomStringConvertible
{
    var id: UUID
    var name: String
    var dosage: String
    var type: MedicationType
    var rawTypeValue: String
    var isActivePrescription: Bool
    var prescriptionStarted: Date?
    var prescriptionStopped: Date?
    var timeTaken: Date?
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.dosage = try container.decode(String.self, forKey: .dosage)
        self.type = try container.decode(MedicationType.self, forKey: .type)
        self.rawTypeValue = try container.decode(String.self, forKey: .rawTypeValue)
        self.isActivePrescription = try container.decode(Bool.self, forKey: .isActivePrescription)
        self.prescriptionStarted = try container.decodeIfPresent(Date.self, forKey: .prescriptionStarted)
        self.prescriptionStopped = try container.decodeIfPresent(Date.self, forKey: .prescriptionStopped)
        self.timeTaken = try container.decodeIfPresent(Date.self, forKey: .timeTaken)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case dosage
        case type
        case rawTypeValue
        case isActivePrescription
        case prescriptionStarted
        case prescriptionStopped
        case timeTaken
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.dosage, forKey: .dosage)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.rawTypeValue, forKey: .rawTypeValue)
        try container.encode(self.isActivePrescription, forKey: .isActivePrescription)
        try container.encodeIfPresent(self.prescriptionStarted, forKey: .prescriptionStarted)
        try container.encodeIfPresent(self.prescriptionStopped, forKey: .prescriptionStopped)
        try container.encodeIfPresent(self.timeTaken, forKey: .timeTaken)
    }
    
    
    init(id: UUID = UUID(), name: String, dosage: String, type: MedicationType, isActivePrescription: Bool ,prescriptionStarted: Date?, prescriptionStopped: Date?, timeTaken: Date?) throws
    {
        if type != .Other
        {
            throw MedicationErrors.MedicationTypeError
        }
        
        self.id = id
        self.name = name
        self.dosage = dosage
        self.type = MedicationType.Analgesic
        self.rawTypeValue = MedicationType.Analgesic.rawValue
        self.isActivePrescription = isActivePrescription
        self.prescriptionStarted = prescriptionStarted
        self.prescriptionStopped = prescriptionStopped
        self.timeTaken = timeTaken
        
        
    }
    
}

extension AnalgesicMedication
{
    var description: String {return "Medication: \(name), Dosage: \(dosage)"}
}


extension ProphylacticMedication
{
    var description: String {return "Medication: \(name), Dosage: \(dosage)"}
}
extension OtherMedication
{
    var description: String {return "Medication: \(name), Dosage: \(dosage)"}
}
