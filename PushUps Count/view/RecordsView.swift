//
//  RecordsView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct RecordsView: View {

    @StateObject
    var recordsVM: RecordsViewModel = .init()
    
    let excersizeTypeUtil: ExcersizeTypeUtil
    
    @State
    var selectedDate: Date
    
    @State
    var showDelAlert = false
    
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
                    
                    // Delete all confirm
                    if showDelAlert {
                        Button("Confirm") {
                            withAnimation {
                                showDelAlert.toggle()
                                print("confirm delete all !")
                                recordsVM.deleteall()
                            }
                        }
                        .foregroundColor(.red)
                        
                        Button("Cancel") {
                            withAnimation {
                                showDelAlert.toggle()
                            }
                        }
                    }
                    
                    Button("Detele all") {
                        print("delete all")
                        withAnimation {
                            showDelAlert.toggle()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
                // MARK: Total records list
                RecordsViewRecordList(recordsVM: recordsVM, excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
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
    
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(excersizeTypeUtil: ExcersizeTypeUtil(), selectedDate: Date())
    }
}
