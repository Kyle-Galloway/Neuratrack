//
//  StatisticsView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import SwiftUI

struct StatisticsView: View {
    
    var viewTypes =  ["Text","Chart"]
    @State var viewSelection: String = "Text"
    
    var body: some View {
        
        
        NavigationStack
        {
            VStack{
                Text("Statistics View: \(viewSelection)").navigationTitle("Statistics").navigationBarTitleDisplayMode(.inline)
                
                Picker("View",selection: $viewSelection)
                {
                    ForEach(viewTypes,id:\.self)
                    {viewType in
                        Text("\(viewType)")
                    }
                }.pickerStyle(.segmented).padding()
                
                if viewSelection == "Chart"
                {
                    ChartWidgetEntryView(entry: ChartWidgetEntry(date: Date())).background(.gray.gradient).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).padding()
                    
                }
                else
                {
                    SimpleWidgetEntryView(entry: SimpleEntry(date: Date(), year: 2024, weekAvg: 1, monthAvg: 4, total: 52)).background(.gray.gradient).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).padding()
                }
                
            }
        }
    }
}

#Preview {
    StatisticsView()
}
