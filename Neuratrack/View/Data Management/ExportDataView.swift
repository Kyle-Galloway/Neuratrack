//
//  ExportDataView.swift
//  Neuratrack
//
//  Created by Kyle Galloway on 23/01/2024.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

struct ExportDataView: View {
    @Query var events: [HeadacheEvent]
    
    @State private var isFileExporterPresented: Bool = false
    @State private var isFailedToExportAlertPresented: Bool = false
    
    @State var encodedJSON: Data? = nil
    @State var exportDateComponents: DateComponents = Calendar.current.dateComponents([.year,.month,.day], from: Date())
    
    let neuratrackFileUTType: UTType = UTType(exportedAs: "com.kylegalloway.neuratrack", conformingTo: .json)
    
    var body: some View {
        NavigationStack
        {
            List
            {
                Text("Events To Export: \(events.count)")
                Button("Export Data")
                {
                    let jsonEncoder = JSONEncoder()
                    do
                    {
                        encodedJSON = try jsonEncoder.encode(events)
                        isFileExporterPresented = true
                    }catch
                    {
                        isFileExporterPresented = false
                        isFailedToExportAlertPresented = true
                    }
                    
                    
                }.fileExporter(isPresented: $isFileExporterPresented, item: encodedJSON, defaultFilename: "\(exportDateComponents.year!)-\(exportDateComponents.month!)-\(exportDateComponents.day!).neuratrack")
                {result in
                    switch result
                    {
                        case .success(let url):
                            print("Saved to  \(url.absoluteString)")
                        case .failure(let error):
                            print("Error: \(error)")
                    }
                }.alert("Failed to export data", isPresented: $isFailedToExportAlertPresented)
                {
                    Button("Ok",role:.cancel){}
                }
                //.buttonBorderShape(.capsule).background(.blue).foregroundColor(.white).clipShape(.capsule)
            }.navigationTitle("Export").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ExportDataView()
}
