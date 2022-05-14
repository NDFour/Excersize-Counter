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
    
    // @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    // @State
    var formatClosure: ((_ dateDesc: String) -> String)
    @State
    var nowRecordDate: String = DateFormatUtil.getDateString(from: Date())
    
    var body: some View {
        VStack {
            List {
                ForEach(0 ..< recordsVM.totalRecords.count, id: \.self) { idx in
                    let excersize = recordsVM.totalRecords[idx]
                    if excersize.timestamp!.description.hasPrefix(nowRecordDate) {
                        Divider()
                        // nowRecordDate = DateFormatUtil.getDateString(from: excersize.timestamp!)
                    }
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
                            recordsVM.delete(at: idx)
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

struct ExcersizeRecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordsViewRecordList(recordsVM: RecordsViewModel(), excersizeTypeUtil: ExcersizeTypeUtil()) {dateDesc in
            return "Preview"
        }
    }
}
