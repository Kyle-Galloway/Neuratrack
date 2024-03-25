//
//  HeadacheEventListViewItem.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 11/02/2024.
//

import SwiftUI
import SwiftData
struct _HeadacheEventListViewItem: View {
    
    @Environment(\.modelContext) var modelContext
    
    @State var entry: HeadacheEvent
    @State var isEditEventSheetPresented: Bool = false
    @State var isViewEventInfoPopoverPresented: Bool = false
    
    var body: some View {
        HStack
        {
            Text(entry.date.formatted())
            Spacer()
            
            //Change to read contents of note and analgesics
            if entry.analgesiaTaken && entry.note.isEmpty == false
            {
                Image(systemName: "pill.fill").foregroundColor(.green)
                Image(systemName: "note.text").foregroundColor(.green)
            }else if entry.analgesiaTaken && entry.note.isEmpty
            {
                Image(systemName: "pill.fill").foregroundColor(.green)
                Image(systemName: "note.text").foregroundColor(.gray)
            }else if entry.analgesiaTaken == false && entry.note.isEmpty == false
            {
                Image(systemName: "pill.fill").foregroundColor(.gray)
                Image(systemName: "note.text").foregroundColor(.green)
            }else if entry.analgesiaTaken == false && entry.note.isEmpty
            {
                Image(systemName: "pill.fill").foregroundColor(.gray)
                Image(systemName: "note.text").foregroundColor(.gray)
            }
            
        }.swipeActions(allowsFullSwipe: false)
        {
            Button
            {
                print("Editing Event")
                isEditEventSheetPresented = true
            }label: {
                Label("Edit",systemImage: "pencil")
            }.tint(.indigo)
            Button(role:.destructive)
            {
                print("Deleting Event")
                modelContext.delete(entry)
            } label: {
                Label("Delete",systemImage: "trash")
            }
        }.onTapGesture {
            isViewEventInfoPopoverPresented.toggle()
        }.sheet(isPresented: $isEditEventSheetPresented)
        {
            EditHeadacheEventView(event: entry)
        }.popover(isPresented: $isViewEventInfoPopoverPresented, content: {
            Text("\(entry.date.formatted()) \(entry.analgesics.count)")
            Text("\(entry.note)")
        })
    }
}

#Preview {
    do{
        let entry = HeadacheEvent(date: Date(), analgesiaTaken: false, analgesics: [try AnalgesicMedication(name: "Test Med", dosage: "Test Dose", type: .Analgesic, isActivePrescription: false, prescriptionStarted: nil, prescriptionStopped: nil, timeTaken: Date())], note: "Note")
        return HeadacheEventListViewItem(entry: entry)
    }catch
    {
        fatalError("Failed to create data for preview")
    }
}

