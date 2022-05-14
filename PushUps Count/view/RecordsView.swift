//
//  RecordsView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct RecordsView: View {
    
    // MARK: CoreData
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    let excersizeTypeUtil = ExcersizeTypeUtil()
    
    @State
    var selectedDate: Date
    
    var body: some View {
        HStack {
            // MARK: Date range list
//            DatePickerBar(exDays: [Date]())
//                .padding()
            // MARK: Date selector
//            DatePicker("Date", selection: $selectedDate, in: ...Date(),  displayedComponents: .date)
//                .datePickerStyle(.stepperField)
            
            VStack {
                HStack {
                    Spacer()
                    Button("Detele all") {
                        print("delete all")
                        withAnimation {
                            deleteAll()
                        }
                    }
                    .padding()
                }
                // MARK: Total records list
                ExcersizeRecordList(excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
            }
        }
    }
    
    // MARK: Excersize Records date formater
    private func formatTimestamp(from dateDesc: String) -> String {
        let firstIdx = dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: ":") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }
    
    // MARK: Deleteall Records
    private func deleteAll() {
        for ex in self.excersizeRecordsCD {
            viewContext.delete(ex)
        }
        saveCoreData()
    }
    
    // MARK: Save CoreData
    private func saveCoreData() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(selectedDate: Date())
    }
}
