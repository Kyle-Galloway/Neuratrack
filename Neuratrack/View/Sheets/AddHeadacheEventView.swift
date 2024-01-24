//
//  AddHeadacheEventView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI

struct AddHeadacheEventView: View {
    
    @Environment(\.dismiss) var dismissSheet
    
    @State var isAddAnalgesiaSheetPresented: Bool = false
    
    @State var eventNotes: String = ""
    
    @State var headacheTime: Date = Date()
    var body: some View {
        NavigationStack
        {
            Form
            {
                DatePicker("Date", selection: $headacheTime).navigationBarTitleDisplayMode(.inline)
                Section
                {
                    List{}
                } header: {Text("Analgesia")}
                
                Button("Add Analgesic")
                {
                    isAddAnalgesiaSheetPresented.toggle()
                }
                Section
                {
                    TextEditor(text: $eventNotes)
                } header:{Text("Notes")}

                Button("Add Headache")
                {
                    dismissSheet()
                }
                
            }.navigationTitle("Add Headache").sheet(isPresented: $isAddAnalgesiaSheetPresented) {
                AddAnalgesicView()
            }
        }
    }
}

#Preview {
    AddHeadacheEventView()
}
