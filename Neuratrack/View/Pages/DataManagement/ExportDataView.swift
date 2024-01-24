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
            List{
                Button("Load Data"){}.navigationTitle("Export").navigationBarTitleDisplayMode(.inline)
                Button("Export Data"){}//.buttonBorderShape(.capsule).background(.blue).foregroundColor(.white).clipShape(.capsule)
            }
        }
    }
}

#Preview {
    ExportDataView()
}
