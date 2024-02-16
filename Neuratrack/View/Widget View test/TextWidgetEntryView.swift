//
//  TextWidgetEntryView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import Foundation
import SwiftUI
import WidgetKit

struct TextWidgetEntryView: View {
    var entry: TextWidgetEntry

    var body: some View {
        ZStack
        {
            //ContainerRelativeShape().fill(.gray.gradient)
            VStack(alignment: .leading)
            {
                HStack()
                {
                    Spacer()
                    Text(String(entry.year)).font(.title3).fontWeight(.bold)
                    Text(":").font(.title3).fontWeight(.bold)
                    Text(String(entry.events.totalEvents())).font(.title3).fontWeight(.bold)
                    Text("events").font(.title3).fontWeight(.bold)
                    
                    Spacer()
                }
                /*
                HStack
                {
                    
                    VStack(alignment: .leading)
                    {
                        Text("Average")
                        Divider()
                        Text("W: \(entry.weekAvg)")
                        Text("M: \(entry.monthAvg)")
                        Text("Total: \(entry.total)")
                    }
                    VStack(alignment: .leading)
                    {
                        Text("Consecutive")
                        Divider()
                        Text("Max Days Free: \(entry.weekAvg)")
                        Text("Serial: \(entry.monthAvg)")
                        Text("Max Serial: \(entry.total)")
                    }
                    
                    VStack(alignment: .leading)
                    {
                        Text("Maximums")
                        Divider()
                        Text("Max Days Free: \(entry.weekAvg)")
                        Text("Max Per Week: \(entry.monthAvg)")
                        Text("Most: \(Date().formatted(.dateTime.month(.abbreviated)))")
                    }
                }
                */
                Grid(alignment: .leading)
                {
                    GridRow
                    {
                        Text("Average")
                        Text("Consecutive")
                        Text("Most")
                    }
                    Divider()
                    GridRow
                    {
                        Text("Week: \(entry.events.averageEventsPerWeek(),specifier: "%.3f")")
                        
                        Text("Days Free: \(entry.events.averageEventsPerWeek(),specifier: "%.3f")")
                        
                        Text("Free Days: \(entry.events.averageEventsPerWeek(),specifier: "%.3f")")
                        
                    }
                    GridRow
                    {
                        
                        Text("Month: \(entry.events.averageEventsPerMonth(),specifier: "%.3f")")
                        
                        Text("Total: \(entry.events.averageEventsPerMonth(),specifier: "%.3f")")
                        
                        Text("In Week: \(entry.events.averageEventsPerMonth(),specifier: "%.3f")")
                    }
                    GridRow
                    {
                        
                        Text("Between: \(entry.events.totalEvents())")
                        
                        Text("Streak: \(entry.events.totalEvents())")
                        
                        Text("In Month: \(Date().formatted(.dateTime.month(.abbreviated)))")
                        
                    }
                    
                    GridRow
                    {
                        Text("")
                        
                        Text("")
                        
                        Text("In A Row: \(String(10))")
                    }
                    
                    GridRow
                    {
                        Text("")
                        
                        Text("")
                        
                        Text("Between: \(String(10))")
                    }
                }
                
                
                /*
                VStack(alignment: .leading)
                {
                    HStack()
                    {
                        Text("W Avg: \(entry.weekAvg)")
                        Text("M Avg: \(entry.monthAvg)")
                        Text("Total: \(entry.total)")
                    }
                    HStack()
                    {
                        Text("Max Days Free: \(entry.weekAvg)")
                        Text("Consecutive Days: \(entry.monthAvg)")
                        Text("Max Consec. Days: \(entry.total)")
                    }
                    
                    HStack()
                    {
                        Text("Max Days Free: \(entry.weekAvg)")
                        Text("Number Of Consecutive Days: \(entry.monthAvg)")
                        Text("Most Occurrences: \(entry.total)")
                    }
                }*/
            }
        }.padding().background(.gray.gradient).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).padding()
        
    }
}

#Preview {
    let date = Date()
    let currentYear = Calendar.current.dateComponents([.year], from: date).year!
    let events = [HeadacheEvent(date: date, analgesiaTaken: false, analgesics: [], note: "Test Note")]
    return TextWidgetEntryView(entry: TextWidgetEntry(date: date, year: currentYear , events: events))
}

#Preview {
    let currentDate = Date()
    let newDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
    let currentYear = Calendar.current.dateComponents([.year], from: newDate).year!
    let events = [HeadacheEvent(date: newDate, analgesiaTaken: false, analgesics: [], note: "Test Note")]
    return TextWidgetEntryView(entry: TextWidgetEntry(date: newDate, year: currentYear , events: events))
}
