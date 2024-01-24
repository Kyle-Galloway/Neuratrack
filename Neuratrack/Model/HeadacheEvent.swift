//
//  HeadacheEvent.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import Foundation
import SwiftData

@Model //TODO: Add conformance for data export
class HeadacheEvent: Identifiable
{
    
    var id = UUID()
    var date: Date
    var analgesiaTaken: Bool
    var analgesics: [Medication]
    var repr: String = ""
    var note: String = ""
    
    init(date: Date, analgesiaTaken: Bool, analgesics: [Medication]?, note: String?) {
        self.date = date
        self.analgesiaTaken = analgesiaTaken
        self.analgesics = []
        if analgesics != nil
        {
            self.analgesics = analgesics!
        }
        if note != nil
        {
            self.note = note!
        }
        self.repr = "\(date), note: \(note)"
    }
}
