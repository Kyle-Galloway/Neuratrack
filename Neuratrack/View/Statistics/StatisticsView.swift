//
//  StatisticsView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import SwiftUI
import SwiftData
struct StatisticsView: View {
    
    var viewTypes =  ["Text","Chart"]
    @State var viewSelection: String = "Text"
    @Query var headaches: [HeadacheEvent]
    @State var years: [Int] = [Int]()
    var body: some View {
        
        
        NavigationStack
        {
            
            HStack
            {
                Text("View").navigationTitle("Statistics").navigationBarTitleDisplayMode(.inline)
                
                Picker("View",selection: $viewSelection)
                {
                    ForEach(viewTypes,id:\.self)
                    {viewType in
                        Text("\(viewType)")
                    }
                }.pickerStyle(.segmented)
            }.padding()
            ScrollView{
                
                if viewSelection == "Chart"
                {
                    ChartWidgetEntryView(entry: ChartWidgetEntry(date: Date())).background(.gray.gradient).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).padding()
                    
                }
                else
                {
                    
                    ForEach($years,id:\.self)
                    {year in
                        Text(String(year.wrappedValue))
                        TextWidgetEntryView(entry: TextWidgetEntry(date: Date(), year: year.wrappedValue, events: headaches.filter{Calendar.current.component(.year, from: $0.date) == year.wrappedValue}))
                    }
                    SimpleWidgetEntryView(entry: SimpleEntry(date: Date(), year: 2024, weekAvg: 1, monthAvg: 4, total: 52)).background(.gray.gradient).clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous)).padding()
                }
                
            }
        }.onAppear
        {
            print("StatisticsView Appeared")
            years = headaches.yearsInArray()
        }
    }
}

#Preview {
    StatisticsView()
}
