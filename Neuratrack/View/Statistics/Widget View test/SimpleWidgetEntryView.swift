//
//  SimpleWidgetEntryView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import Foundation
import SwiftUI
import WidgetKit

struct SimpleWidgetEntryView: View {
    var entry: SimpleEntry

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
                    Text(String(entry.total)).font(.title3).fontWeight(.bold)
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
                        Text("Week: \(entry.weekAvg)")
                        
                        Text("Days Free: \(entry.weekAvg)")
                        
                        Text("Free Days: \(entry.weekAvg)")
                        
                    }
                    GridRow
                    {
                        
                        Text("Month: \(entry.monthAvg)")
                        
                        Text("Total: \(entry.monthAvg)")
                        
                        Text("In Week: \(entry.monthAvg)")
                    }
                    GridRow
                    {
                        
                        Text("Between: \(entry.total)")
                        
                        Text("Streak: \(entry.total)")
                        
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
        }.padding()
        
    }
}
