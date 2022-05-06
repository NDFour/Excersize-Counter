//
//  DashboardView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: CoreData
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    let excersizeTypeUtil = ExcersizeTypeUtil()
    @State
    var excersizeSelected: Int = 0
    
    var body: some View {
        VStack {
            // MARK: Total count
            Text("Today: \(calcTotalCount(type: "pushups"))")
                .font(.largeTitle)
                .bold()
                .padding()
            // MARK: type tab
            ExcersizeTypeTab(excersizeTypeUtil: excersizeTypeUtil, excersizeSelected: $excersizeSelected)
            Divider()
                .padding()
            // MARK: plus button
            PlusButton(excersizeTypeUtil: excersizeTypeUtil, excersizeSelected: $excersizeSelected)

            // MARK: excersize record list
            if (excersizeRecordsCD.count == 0) {
                Text("今天还没有记录，快点开始锻炼吧！")
                    .padding()
            }
            // List here
            ExcersizeRecordList(excersizeTypeUtil: excersizeTypeUtil)
        }
    }
    
    // MARK: Calculate total count
    private func calcTotalCount(type: String) -> Int {
        var total = 0
        for cc in excersizeRecordsCD {
            total += Int(cc.count)
        }
        return total
    }
    
    // MARK: Format data
//    private func getFormatedDate() -> String {
//        let originStr = Date().description
//        let firstIdx = originStr.firstIndex(of: "-") ?? originStr.startIndex
//        let secondIdx = originStr.firstIndex(of: " ") ?? originStr.endIndex
//        let rel = originStr[originStr.index(after: firstIdx) ..< secondIdx]
//        return String(rel)
//    }
    
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



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
