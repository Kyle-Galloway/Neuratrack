//
//  AddHeadacheEventView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 16/01/2024.
//

import SwiftUI
import SwiftData
struct _AddHeadacheEventView: View {
    
    @Environment(\.dismiss) var dismissSheet
    @Environment(\.modelContext) var modelContext
    
    @State var isAddAnalgesiaSheetPresented: Bool = false
    
    @State var eventNotes: String = ""
    
    @State var analgesics: [AnalgesicMedication] = []
    
    @State var headacheTime: Date = Date()
    
    @State var newEvent: HeadacheEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, note: "")
    //@State var newEvent: HeadacheEvent = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [], note: "")
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
                
            }.navigationTitle("Add Headache").sheet(isPresented: $isAddAnalgesiaSheetPresented) {
                AddAnalgesicView(parentHeadacheEvent: newEvent)
            }.toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Cancel")
                    {
                        dismissSheet()
                    }
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Add")
                    {
                        let newEvent = HeadacheEvent(date: headacheTime, analgesiaTaken: analgesics.count > 0, note: eventNotes)
                        //let newEvent = HeadacheEvent(date: headacheTime, analgesiaTaken: analgesics.count > 0, analgesics: analgesics, note: eventNotes)
                        modelContext.insert(newEvent)
                        dismissSheet()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHeadacheEventView()
}
