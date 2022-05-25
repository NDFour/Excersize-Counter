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
                controller.save()
                succCount += 1
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
    
}
