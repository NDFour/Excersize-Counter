//
//  DashboardViewRecordsList.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import SwiftUI

struct DashboardViewRecordsList: View {
    
    @StateObject
    var dashboardVM: DashboardViewModel
    
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    @State
    var formatClosure: ((_ dateDesc: Date) -> String)
    
    var body: some View {
        VStack {
            List {
                ForEach(0 ..< dashboardVM.todayRecords.count, id: \.self) { idx in
                    let excersize = dashboardVM.todayRecords[idx]
                    HStack {
                        Text("\(idx + 1)")
                            .frame(width: 25)
                        if let img = excersizeTypeUtil.findImgByTypeCode(typeCode: excersize.type ?? "404") {
                            Image("\(img)")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        
                        if let tt = excersize.timestamp {
                            Text(formatClosure(tt))
                        }
                        Spacer()
                        Text("+ \(excersize.count)")
                        Button(action: {
                            dashboardVM.delete(at: idx)
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

//
//struct DashboardViewRecordsList_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardViewRecordsList()
//    }
//}
