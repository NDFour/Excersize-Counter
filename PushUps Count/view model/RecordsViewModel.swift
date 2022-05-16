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
        // grouped by date
        getRecordsByDay()
    }
    
    /**
     Get all Recored, grouped by date
     */
    func getRecordsByDay() {
        print("RecordsViewModel getRecordsByDay...")
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
        for kk in dateArr.reversed() {
            let tmp = RecordsOfDay(date: kk, records: recMap[kk] ?? [])
            recordsByDay.append(tmp)
        }
        
    }
    
    /**
     delete by idx
     */
    func delete(at idx: Int) {
        // delete
        controller.container.viewContext.delete(totalRecords[idx])
        // save
        controller.save()
        // get
        getAllRecords()
    }
    
    /**
     delete by obj
     */
    func delete(of obj: ExcersizeCD) {
        // delete
        controller.container.viewContext.delete(obj)
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
    
    /**
     Export all records data to JSON
     */
    func exportToJsonString() -> String {
        //        let encodedData = try JSONEncoder().encode(city)
        //        let jsonString = String(data: encodedData,
        //                                encoding: .utf8)
        var excersizeVMs: [ExcersizeRecordViewModel] = []
        for ex in totalRecords {
            excersizeVMs.append(ExcersizeRecordViewModel(type: ex.type!, count: Int(ex.count), timestamp: ex.timestamp!))
        }
        
        var jsonString = ""
        do {
            let encodedData = try JSONEncoder().encode(excersizeVMs)
            jsonString = String(data: encodedData, encoding: .utf8) ?? ""
        } catch {
            print("Error occur when exportToJsonString: \(error)")
        }
        
        return jsonString
    }
    
    
}

struct ExcersizeRecordViewModel: Codable {
    var type: String
    var count: Int
    var timestamp: Date
}

