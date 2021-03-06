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
    
    @State
    var showJsonSheet = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Total:")
                    .bold()
                    .padding(.horizontal)
                Text("\(recordsVM.totalRecords.count) records")
                Button("Export") {
                    print("Export all records...")
                    showJsonSheet = true
                }
                .padding(.horizontal)
                .sheet(isPresented: $showJsonSheet, onDismiss: {
                    print("exportToJson sheet is dismiss...")
                }, content: {
                    ExportToJson(recordsVM: recordsVM, showJsonSheet: $showJsonSheet)
                        .frame(width: 550, height: 400)
                })
                
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
            HStack {
                Spacer()
                Button("Fold All") {
                    recordsVM.foldAll()
                }
                Button("Unold All") {
                    recordsVM.unfoldAll()
                }
            }
            .padding(.horizontal)
            RecordsViewRecordList(recordsVM: recordsVM, excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
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
