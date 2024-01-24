//
//  ChartWidgetEntryView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import Foundation
import SwiftUI
import WidgetKit
import Charts

struct ChartWidgetEntryView: View {
    var entry: ChartWidgetEntry
    var months = 0...12

    var body: some View {
        ZStack
        {
            //ContainerRelativeShape().fill(.gray.gradient)
            VStack(alignment: .leading)
            {
                HStack()
                {
                    Spacer()
                    Text(String(entry.date.formatted(date: .abbreviated, time: .shortened))).font(.title3).fontWeight(.bold)
                    Text(":").font(.title3).fontWeight(.bold)
                    Text(String(entry.date.description)).font(.title3).fontWeight(.bold)
                    Text("events").font(.title3).fontWeight(.bold)
                    
                    Spacer()
                }
                
                Chart
                {
                    ForEach(months, id:\.self)
                    {month in
                        
                        BarMark(x: .value("Month", month),y:.value("Value", month))
                        
                    }
                }
            }
        }.padding()
        
    }
}
