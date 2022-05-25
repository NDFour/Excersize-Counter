//
//  ExcersizeRecordList.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct RecordsViewRecordList: View {
    
    @StateObject
    var recordsVM: RecordsViewModel

    var excersizeTypeUtil: ExcersizeTypeUtil
    var formatClosure: ((_ dateDesc: String) -> String)
    
    @State
    var nowRecordDate: String = DateFormatUtil.getDateString(from: Date())
    
    var body: some View {
        List {
            // records of many days
            ForEach(0 ..< recordsVM.recordsByDay.count, id: \.self) { outIdx in
                let recordsOneDay = recordsVM.recordsByDay[outIdx]
                Divider()
                HStack {
                    Text("\(recordsOneDay.date)")
                        .font(.title)
                        .bold()
                    Spacer()
                    Text("\(recordsOneDay.records.count) items")
                    Button(action: {
                        recordsVM.showList[outIdx].toggle()
                        print("showList: \(recordsVM.showList[outIdx])")
                    }, label: {
                        Image(systemName: recordsVM.showList[outIdx] ? "lock.open" : "lock")
                    })
                }
                .padding()
                // records of one day
                if recordsVM.showList[outIdx] {
                    ForEach(0 ..< recordsOneDay.records.count, id: \.self) { idx in
                        let excersize = recordsOneDay.records[idx]
                        HStack {
                            Text("\(idx + 1)")
                                .frame(width: 25)
                            if let img = excersizeTypeUtil.findImgByTypeCode(typeCode: excersize.type ?? "404") {
                                Image("\(img)")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            
                            Text(formatClosure(excersize.timestamp?.description ?? "nil"))
                            Spacer()
                            Text("+ \(excersize.count)")
                            Button(action: {
                                withAnimation {
                                    recordsVM.delete(of: excersize)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 6)
                        }
                    }
                }
            }
            
        }
    }
    
}

struct ExcersizeRecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordsViewRecordList(recordsVM: RecordsViewModel(), excersizeTypeUtil: ExcersizeTypeUtil()) {dateDesc in
            return "Preview"
        }
    }
}
