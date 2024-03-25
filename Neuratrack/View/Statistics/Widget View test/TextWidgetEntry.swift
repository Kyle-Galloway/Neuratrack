//
//  TextWidgetEntry.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import Foundation
import WidgetKit

struct TextWidgetEntry: TimelineEntry {
    let date: Date // Required To Conform To TimelineEntry For WidgetKit
    let year: Int
    let events: [HeadacheEvent]
    
    /*
    func mostConsecutiveEvents() -> Int
    {
        let dates = events.map { $0.date }
        
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
                maxConsecutive = max(maxConsecutive,consecutiveCounter)
            }else
            {
                
                consecutiveCounter = 1
            }
            
        }
        return maxConsecutive
    }
    
    func mostDaysBetweenEvents() throws -> Int
    {
        return try daysBetweenEvents().max()!
    }
    
    func daysBetweenEvents() throws -> [Int]
    {
        
        // Does not account for daylight savings i.e. BST Starts adding 1 hour causing 23 hour day, BST Ends Causing 25 hour day effecting the day component of date components causing calculation to be off by one when date range is over these periods
        //TODO: use TimeZone.isDaylightSavingsTime(for: Date) to adjust calculation
        let startOfYear = try Date("\(year)-01-01T00:00:00Z",strategy: .iso8601)
        var daysBetween = [Int]()
        
        let dates = events.map { $0.date }
        
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
        var months: Double  = Calendar.current.component(.year, from: events.last!.date) < Calendar.current.component(.year, from: Date()) ? 12.0 : Double(Calendar.current.component(.month, from: Date()))
        return Double(totalEvents())/months
    }
    
    // Returns the average number of events per week, adjusting for non complete years.
    func averageEventsPerWeek() -> Double
    {
        var weeks: Double = Calendar.current.component(.year, from: events.last!.date) < Calendar.current.component(.year, from: Date()) ? 52.0 : Double(Calendar.current.component(.weekOfYear, from: Date()))
        
        return Double(totalEvents())/weeks
    }

    
    func totalEvents() -> Int
    {
        return events.count
    }
    */
}
