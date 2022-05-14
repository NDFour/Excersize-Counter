//
//  DashboardView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI

struct DashboardView: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    @StateObject
    var dashboardVM: DashboardViewModel = .init()
    
    let excersizeTypeUtil: ExcersizeTypeUtil
    @State
    var excersizeSelected: Int = 0
    
    var body: some View {
        VStack {
            // MARK: Total count
            Text("Today: \(dashboardVM.calcTotalCount(type: "pushups"))")
                .font(.largeTitle)
                .bold()
                .padding()
            // MARK: type tab
            ExcersizeTypeTab(dashboardVM: dashboardVM, excersizeTypeUtil: excersizeTypeUtil, excersizeSelected: $excersizeSelected)
            Divider()
                .padding()
            // MARK: plus button
            PlusButton(dashboardVM: dashboardVM, excersizeTypeUtil: excersizeTypeUtil, excersizeSelected: $excersizeSelected)

            // MARK: excersize record list
            if (excersizeRecordsCD.count == 0) {
                Text("今天还没有记录，快点开始锻炼吧！")
                    .padding()
            }
            // List here
            DashboardViewRecordsList(dashboardVM: dashboardVM, excersizeTypeUtil: excersizeTypeUtil, formatClosure: DateFormatUtil.getHourMinute)
        }
    }
    
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(excersizeTypeUtil: ExcersizeTypeUtil())
    }
}
