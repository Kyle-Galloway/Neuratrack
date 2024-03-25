//
//  HeadacheEvent.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 15/01/2024.
//

import Foundation
import SwiftData
import OrderedCollections

@Model //TODO: Add codable conformance for data export
class HeadacheEvent: Identifiable, Codable, CustomStringConvertible, NSCopying
{
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = HeadacheEvent(date: date, analgesiaTaken: analgesiaTaken, analgesics: analgesics, note: note)
        return copy
    }
    
    
    var id = UUID()
    var date: Date
    var analgesiaTaken: Bool
    var analgesics: [AnalgesicMedication]
    var note: String = ""
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.analgesiaTaken = try container.decode(Bool.self, forKey: .analgesiaTaken)
        self.analgesics = try container.decode([AnalgesicMedication].self, forKey: .analgesics)
        self.note = try container.decode(String.self, forKey: .note)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case date
        case analgesiaTaken
        case analgesics
        case note
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.date, forKey: .date)
        try container.encode(self.analgesiaTaken, forKey: .analgesiaTaken)
        try container.encode(self.analgesics, forKey: .analgesics)
        try container.encode(self.note, forKey: .note)
    }
    
    init(date: Date = Date(), analgesiaTaken: Bool = false, analgesics: [AnalgesicMedication] = [], note: String = "") {
        self.date = date
        self.analgesiaTaken = analgesiaTaken
        self.analgesics = analgesics
        self.note = note
    }
    
    /*
    init(date: Date = Date(), analgesiaTaken: Bool = false, note: String = "") {
        self.date = date
        self.analgesiaTaken = analgesiaTaken
        self.note = note
        self.repr = "\(date), note: \(note)"
    }
    */
}

extension HeadacheEvent
{
    var description: String {return "\(date), Analgesics: \(analgesics) note:\(note)"}
    
}



extension Array where Element == HeadacheEvent
{
    
    
    func yearsInArray() -> [Int]
    {
        let years: [Int] = map{Calendar.current.component(.year, from: $0.date)}
        let setOfYears: [Int] = Array<Int>(Set(years))
        return setOfYears.sorted().reversed()
    }
    
    func getEventCountsByWeekOfYear_Filter() -> OrderedDictionary<Int, Int>
    {
        let weeks = 1...53
        var counts = OrderedDictionary<Int,Int>()
        for week in weeks
        {
            counts[week] = filter{Calendar.current.component(.weekOfYear, from: $0.date) == week}.count
        }
        counts.sort()
        return counts
    }
    
    func getEventCountsByWeekOfYear_Reduce() -> OrderedDictionary<Int,Int>
    {
        
        var data: OrderedDictionary<Int, Int> = reduce(into: [:]){counts, event in
            
            let week = Calendar.current.component(.weekOfYear, from: event.date)
            counts[week, default: 0] += 1}
        data.sort()
        return data
    }
    
    func mostConsecutiveEvents() -> Int
    {
        let dates = map { $0.date }
        
        var consecutiveCounter: Int = 0
        var maxConsecutive: Int = 1
        for index in 0..<dates.count - 1
        {
            let diff = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dates[index + 1], to: dates[index])
            print(diff)
            //let diff = abs(Calendar.current.dateComponents([.day], from: dates[index+1], to: dates[index]).day!)
            if abs(diff.day!) < 2
            {
                consecutiveCounter += 1
                maxConsecutive = Swift.max(maxConsecutive,consecutiveCounter)
            }else
            {
                
                consecutiveCounter = 1
            }
            
        }
        return maxConsecutive
    }
    
    func mostDaysBetweenEvents(year:Int) throws -> Int
    {
        return try daysBetweenEvents(year:year).max()!
    }
    
    func daysBetweenEvents(year: Int) throws -> [Int]
    {
        
        // Does not account for daylight savings i.e. BST Starts adding 1 hour causing 23 hour day, BST Ends Causing 25 hour day effecting the day component of date components causing calculation to be off by one when date range is over these periods
        //TODO: use TimeZone.isDaylightSavingsTime(for: Date) to adjust calculation
        let startOfYear = try Date("\(year)-01-01T00:00:00Z",strategy: .iso8601)
        var daysBetween = [Int]()
        
        let dates = map { $0.date }
        
        //daysBetween.append(Calendar.current.dateComponents([.day], from: startOfYear, to: dates.first!).day!)
        
        //let datesSequence = dates.map{Calendar.current.dateComponents([.day], from: $0, to: $1).day!}
        
        for index in 0..<dates.count - 1
        {
            let startDate = dates[index]
            let endDate = dates[index + 1]
            
            let dateRange = startDate...endDate
            let nextDaylightSavingsTransition = Calendar.current.timeZone.nextDaylightSavingTimeTransition(after: startDate)!
            let doesDaylightSavingTransitionOccurInRange: Bool = dateRange.contains(nextDaylightSavingsTransition)
            var dstOffsetCorrection: Int = 0
            
            if doesDaylightSavingTransitionOccurInRange
            {
                print("Contains DST Change")
                let dstOffset = Calendar.current.timeZone.daylightSavingTimeOffset(for: nextDaylightSavingsTransition)
                print(dstOffset)
                let dstOffsetDirection = dstOffset.sign
                print(dstOffsetDirection)
                switch dstOffsetDirection {
                case .plus:
                    dstOffsetCorrection = 1
                case .minus:
                    dstOffsetCorrection = -1
                }
            }
            
            //let diff = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dates[index], to: dates[index+1])
            
            var diff = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day!
            print("From: \(startDate), To: \(endDate), Day: \(diff), Diff: \(Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: startDate, to: endDate))")
            
            daysBetween.append(diff)
            /*
            if Calendar.current.dateComponents([.day], from: dates[index]).day! == Calendar.current.dateComponents([.day], from: dates[index + 1]).day!
            {
                daysBetween.append(0)
            }else
            {
                daysBetween.append(diff)
                /*
                if diff.day! == 0 && diff.hour! <= 23
                {
                    daysBetween.append(0)
                }else if diff.day! == 1 && diff.hour! <= 23
                {
                    daysBetween.append(0)
                }else
                {
                    daysBetween.append(Calendar.current.dateComponents([.day], from: dates[index], to: dates[index+1]).day!)
                }*/
            }*/
            
           
        }
        
        return daysBetween
        
    }
    // Returns the average number of events per month, adjusting for non complete years
    func averageEventsPerMonth() -> Double
    {
        var months: Double  = Calendar.current.component(.year, from: last!.date) < Calendar.current.component(.year, from: Date()) ? 12.0 : Double(Calendar.current.component(.month, from: Date()))
        return Double(totalEvents())/months
    }
    
    // Returns the average number of events per week, adjusting for non complete years.
    func averageEventsPerWeek() -> Double
    {
        var weeks: Double = Calendar.current.component(.year, from: last!.date) < Calendar.current.component(.year, from: Date()) ? 52.0 : Double(Calendar.current.component(.weekOfYear, from: Date()))
        
        return Double(totalEvents())/weeks
    }

    
    func totalEvents() -> Int
    {
        return count
    }
}
