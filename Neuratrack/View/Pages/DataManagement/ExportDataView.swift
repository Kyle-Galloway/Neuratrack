//
//  ExportDataView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 23/01/2024.
//

import SwiftUI

struct ExportDataView: View {
    var body: some View {
        NavigationStack
        {
            Text("Export view").navigationTitle("Export").navigationBarTitleDisplayMode(.inline)
            Button("Load Data"){}
            Button("Export Data"){}.buttonBorderShape(.capsule).background(.blue).foregroundColor(.white).clipShape(.capsule)
        }
    }
}

#Preview {
    ExportDataView()
}
