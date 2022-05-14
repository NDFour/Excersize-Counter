//
//  RecordsView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct RecordsView: View {
    
    // MARK: CoreData
//    @Environment(\.managedObjectContext)
//    private var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
//    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    @StateObject
    var recordsVM: RecordsViewModel = .init()
    
    let excersizeTypeUtil: ExcersizeTypeUtil
    
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
                    Text("Total:")
                        .bold()
                        .padding(.horizontal)
                    Text("\(recordsVM.totalRecords.count) records")
                    Spacer()
                    Button("Detele all") {
                        print("delete all")
                        withAnimation {
                            deleteAll()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                // MARK: Total records list
                RecordsViewRecordList(recordsVM: recordsVM, excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
            }
        }
        .onAppear(perform: {
            recordsVM.getRecordsByDay()
        })
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
        recordsVM.deleteall()
    }
    
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(excersizeTypeUtil: ExcersizeTypeUtil(), selectedDate: Date())
    }
}
