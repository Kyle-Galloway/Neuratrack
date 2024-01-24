//
//  StatisticsGridViewItem.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 19/01/2024.
//

import SwiftUI

struct StatisticsGridViewItem: View {
    @State var Year: Int
    @State var weekAvg:Int
    @State var monthAvg: Int
    @State var total: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview(traits:.sizeThatFitsLayout){
    StatisticsGridViewItem(Year: 2024, weekAvg: 1, monthAvg: 4, total: 4)
}
