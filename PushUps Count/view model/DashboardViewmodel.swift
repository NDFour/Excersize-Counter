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

        //        print("Get today...")
        //        print(Date())
        //        let dd = getCurrentTimezoneDate()
        //        print(dd)
        //        print(calendar.startOfDay(for: dd))
        //        print(calendar.startOfDay(for: Date()))

        let dateFrom = calendar.startOfDay(for: getCurrentTimezoneDate()) // eg. 2016-10-10 00:00:00
//        let dateTmp = calendar.date(byAdding: .hour, value: 8, to: dateFrom)!
        let dateTmp = dateFrom
        let dateTo = calendar.date(byAdding: .hour, value: 24, to: dateTmp)
        print("Date from: \(dateTmp.description) to: \(dateTo!.description)")
        let predicate = NSPredicate(format: "timestamp >= %@ AND timestamp < %@", dateTmp as NSDate, dateTo! as NSDate)
        req.predicate = predicate
        
        do {
            todayRecords = try controller.container.viewContext.fetch(req)
        } catch {
            fatalError("Fatal error in getTodayRecords: \(error)")
        }
    }
    
    // Add a record
    func add(count: Int, type: String) {
        let obj = ExcersizeCD(context: controller.container.viewContext)
        obj.count = Int16(count)
        obj.timestamp = getCurrentTimezoneDate()
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
    
    // MARK: Get current timezone date
    private func getCurrentTimezoneDate() -> Date {
        let d1 = Date()
        // let timeZone = TimeZone.current
        let timeZone = TimeZone(identifier: "Asia/Shanghai") ?? TimeZone.current
        let interval: Int = timeZone.secondsFromGMT(for: d1)
        let currentDate = d1.addingTimeInterval(Double(interval))
        print("Current Timezone date: \(currentDate)")
        return currentDate
    }
    
    
}
