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
            ExcersizeRecordList(excersizeTypeUtil: excersizeTypeUtil, formatClosure: formatTimestamp)
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
    
    // MARK: Excersize Records date formater
    private func formatTimestamp(from dateDesc: String) -> String {
        let firstIdx = dateDesc.firstIndex(of: " ") ?? dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: ":") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }
    
    // MARK: Get today's date
    private func getTodayDate() -> String {
        let dateDesc = Date().description
        let firstIdx = dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: " ") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }
    
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
