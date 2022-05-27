//
//  ImportDataViewmodel.swift
//  PushUps Count
//
//  Created by mac on 2022/5/25.
//

import Foundation

class ImportDataViewmodel: ObservableObject {
    @Published
    var jsonStr: String = ""
    @Published
    var type: String = "100"

    var controller: PersistentController = PersistentController.shared
    
    func parseStrByNewline() {
        let lines = jsonStr.components(separatedBy: "\n")
        print("\(lines.count) lines")
        
        var succCount = 0
        for line in lines {
            // MARK: Parse user input
            if line.components(separatedBy: " ").count < 2 {
                print("非法记录.跳过")
                continue
            }
            let time = line.components(separatedBy: " ")[0]
            let count = line.components(separatedBy: " ")[1]
            if Int(count) ?? 0 > 1 {
                print("\(time) - \(count)")
                // MARK: Create new core data obj
                let obj = ExcersizeCD(context: controller.container.viewContext)
                obj.count = Int16(count)!
                obj.timestamp = parseDateString(from: time)
                obj.type = self.type
                print("默认导入数据为 俯卧撑: \(obj)")
                // MARK: save
                if checkIfInputDateAfterNow(inputDate: obj.timestamp ?? Date()) {
                    
                } else {
                    controller.save()
                    succCount += 1
                }
            }
        }
        // MARK: clean jsonStr
        jsonStr = "Import \(succCount) records success!"
    }
    
    func parseDateString(from of: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        // 20220525-19:46
        dateFormatter.dateFormat = "yyyyMMdd-HH:mm"
        let dd = dateFormatter.date(from: of)
        return dd ?? Date()
    }
    
    /**
        * Import json data and converto to array of Record
        */
    func importJsonDataAndStore() {
        let data = jsonStr.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            var parseRecords: [JsonRecord] = []
            try parseRecords = decoder.decode([JsonRecord].self, from: data)
            print("Parse json succ: \(parseRecords.count)")
            var succCnt = 0
            for parse in parseRecords {
                // MARK: Create new core data obj
                let obj = ExcersizeCD(context: controller.container.viewContext)
                obj.count = Int16(parse.count)
                obj.timestamp = parse.timestamp
                obj.type = parse.type
                // MARK: save
                if checkIfImportRecordsValid(raw: parse) {
                    controller.save()
                    succCnt += 1
                }
            }
            print("succCnt: \(succCnt)")
            jsonStr = "Import from json: parsed - \(parseRecords.count), succ - \(succCnt)"
        } catch {
            print("Encounted err when importJsonDataAndStore: \(error)")
        }
    }
    
    /**
    检查导入的数据是否合法
     */
    func checkIfImportRecordsValid(raw: JsonRecord) -> Bool {
        if checkIfInputDateAfterNow(inputDate: raw.timestamp) {
            return false
        }
        return true
    }
    
    func checkIfInputDateAfterNow(inputDate: Date) -> Bool {
        let now = Date()
        return inputDate > now
    }
    
}

/**
 用于表示从 json 字符串解析到的数据
 */
struct JsonRecord: Decodable {
    var type: StringLiteralType
    var count: Int
    var timestamp: Date
}
