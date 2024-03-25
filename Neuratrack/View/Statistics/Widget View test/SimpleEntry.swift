//
//  SimpleEntry.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import Foundation
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let year: Int
    let weekAvg: Int
    let monthAvg: Int
    let total: Int
}
