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
            DatePickerBar(exDays: [Date]())
                .padding()
            // MARK: Date selector
//            DatePicker("Date selector", selection: $selectedDate, in: ...Date(),  displayedComponents: .date)
//                .datePickerStyle(.graphical)
            
            // MARK: Total records list
            ExcersizeRecordList(excersizeTypeUtil: excersizeTypeUtil)
        }
    }
}

struct RecordsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsView(selectedDate: Date())
    }
}
