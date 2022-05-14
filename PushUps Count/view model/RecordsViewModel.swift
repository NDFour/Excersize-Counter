//
//  RecordsViewModel.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import Foundation
import CoreData

struct RecordsOfDay: Identifiable {
    var id = UUID()
    var date: String
    var records: [ExcersizeCD]
}


class RecordsViewModel: ObservableObject {
    @Published
    var totalRecords: [ExcersizeCD] = []
    @Published
    var recordsByDay: [RecordsOfDay] = []
    
    var controller: PersistentController = PersistentController.shared
    
    init() {
        print("RecordsViewModel init...")
        getAllRecords()
        getRecordsByDay()
    }
    
    func getAllRecords() {
        print("RecordsViewModel getAllRecords...")
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
    
    /**
     Get all Recored, grouped by date
     */
    func getRecordsByDay() {
        // get date array
        var dateArr = [String]()
        var recMap = [String: [ExcersizeCD]]()
        for rec in totalRecords {
            // if timestamp is not nil
            if let tt = rec.timestamp {
                if !dateArr.contains(DateFormatUtil.getDateString(from: tt)) {
                    dateArr.append(DateFormatUtil.getDateString(from: tt))
                    // define a key in map
                    recMap[DateFormatUtil.getDateString(from: tt)] = []
                }
                // insert record to array inside map
                recMap[DateFormatUtil.getDateString(from: tt)]?.append(rec)
            } else {
                // pass
            }
        }
        
        recordsByDay = []
        for kk in recMap.keys {
            let tmp = RecordsOfDay(date: kk, records: recMap[kk] ?? [])
            recordsByDay.append(tmp)
        }
    }
    
    func delete(at idx: Int) {
        // delete
        controller.container.viewContext.delete(totalRecords[idx])
        // save
        controller.save()
        // get
        getAllRecords()
    }
    
    func deleteall() {
        // delete
        for rec in totalRecords {
            controller.container.viewContext.delete(rec)
        }
        // save
        controller.save()
        // get
        getAllRecords()
    }
    
    
}


