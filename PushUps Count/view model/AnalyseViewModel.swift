//
//  AnalyseViewModel.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import Foundation
import CoreData

class AnalyzseViewModel: ObservableObject {
    @Published
    var totalRecords: [ExcersizeCD] = []
    
    var totalCount: Int {
        var total = 0
        for ex in totalRecords {
            total += Int(ex.count)
        }
        return total
    }
    
    var controller: PersistentController = PersistentController.shared
    
    init() {
        print("AnalyzseViewModel init...")
        getAllRecords()
    }
    
    func getAllRecords() {
        print("AnalyzseViewModel getAllRecords...")
        let req = NSFetchRequest<ExcersizeCD>(entityName: "ExcersizeCD")
        // Sort
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        req.sortDescriptors = [sort]
        // @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
        do {
            totalRecords = try controller.container.viewContext.fetch(req)
        } catch {
            fatalError("Fatal error in getAllRecords: \(error)")
        }
    }
    
    // MARK: Calculate count of some type of excersize
    func calcCountOfType(type: String) -> Int {
        var total = 0
        for cc in totalRecords {
            if cc.type == type {
                total += Int(cc.count)
            }
        }
        return total
    }
    
    // Get how many days you have excersized
    func getDaysExcersized() -> Int {
        var exDays = 0
        var lastDay = ""
        for ex in totalRecords {
            if let exDate = ex.timestamp {
                if DateFormatUtil.getDateString(from: exDate) != lastDay {
                    lastDay = DateFormatUtil.getDateString(from: exDate)
                    exDays += 1
                }
            }
        }
        return exDays
    }
    
    /**
     Get max count by type
     */
    func getMax(of type: String) -> (max: Int, date: Date) {
        var max = 0
        var date: Date = Date()
        for cc in totalRecords {
            if cc.type == type {
                if max < cc.count {
                    max = Int(cc.count)
                    date = cc.timestamp!
                }
            }
        }
        return (max, date)
    }
    
    
    
}
