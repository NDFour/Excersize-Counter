//
//  DashboardViewmodel.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import Foundation
import CoreData

class DashboardViewModel: ObservableObject {
    @Published
    var todayRecords: [ExcersizeCD] = []
    
    var controller: PersistentController = PersistentController.shared
    
    init() {
        print("DashboardViewModel init...")
        getTodayRecords()
    }
    
    // Get all records of today
    func getTodayRecords() {
        print("DashboardViewModel getTodayRecords...")
        let req = NSFetchRequest<ExcersizeCD>(entityName: "ExcersizeCD")
        // Sort
        let sort = NSSortDescriptor(key: "timestamp", ascending: true)
        req.sortDescriptors = [sort]
        // @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
        
        // predicate
        // Get the current calendar with local time zone
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.system

        print(calendar.startOfDay(for: getDateByTimezoneShangHai()))

        let dateFrom = calendar.startOfDay(for: getDateByTimezoneShangHai()) // eg. 2016-10-10 00:00:00
        var dateTmp = calendar.date(byAdding: .hour, value: -16, to: dateFrom)
        dateTmp = calendar.date(byAdding: .day, value: 1, to: dateTmp!)
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateTmp!)
        print("Date from: \(dateTmp!.description) to: \(dateTo!.description)")
        let predicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@", dateTmp! as NSDate, dateTo! as NSDate)
        req.predicate = predicate
        
        do {
            todayRecords = try controller.container.viewContext.fetch(req)
        } catch {
            fatalError("Fatal error in getTodayRecords: \(error)")
        }
    }
    
    // Add a record
    func add(count: Int, timestamp: Date, type: String) {
        let obj = ExcersizeCD(context: controller.container.viewContext)
        obj.count = Int16(count)
        obj.timestamp = timestamp
        obj.type = type
        // save
        controller.save()
        // get
        getTodayRecords()
    }
    
    // Delete a record
    func delete(at idx: Int) {
        // delete
        controller.container.viewContext.delete(todayRecords[idx])
        // save
        controller.save()
        // get
        getTodayRecords()
    }
    
    // MARK: Calculate count of some type of excersize
    func calcCountOfType(type: String) -> Int {
        var total = 0
        for cc in todayRecords {
            if cc.type == type {
                total += Int(cc.count)
            }
        }
        return total
    }
    
    // MARK: Calculate total count
    func calcTotalCount(type: String) -> Int {
        var total = 0
        for cc in todayRecords {
            total += Int(cc.count)
        }
        return total
    }
    
    func getDateByTimezoneShangHai() -> Date {
        let d1 = Date()
        // let timeZone = TimeZone.current
        let timeZone = TimeZone(identifier: "Asia/Shanghai") ?? TimeZone.current
        let interval: Int = timeZone.secondsFromGMT(for: d1)
        let currentDate = d1.addingTimeInterval(Double(interval))
        return currentDate
    }
    
    
}
