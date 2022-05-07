//
//  RecordsView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct RecordsView: View {
    
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
            
            // MARK: Total records list
            ExcersizeRecordList(excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
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
        RecordsView(selectedDate: Date())
    }
}
