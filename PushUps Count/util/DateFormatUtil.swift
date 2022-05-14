//
//  DateFormatUtil.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import Foundation

struct DateFormatUtil {
    
    // 2022-05-14 18:21:00 0000 -> 18:21
    static func getHourMinute(from date: Date) -> String {
        let dateDesc = date.description
        let firstIdx = dateDesc.firstIndex(of: " ") ?? dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: ":") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }
    
    /**
     2022-05-14 18:21:00 0000 -> 2022-05-14
     */
    static func getDateString(from date: Date) -> String {
        let secondIdx = date.description.firstIndex(of: " ") ?? date.description.endIndex
        let rel = date.description[date.description.startIndex ..< secondIdx]
        return String(rel)
    }
    
    // MARK: Get today's date
    // 2022-05-14 18:21:00 0000 -> 2022-05-14 18:21:00
    private func getTodayDate() -> String {
        let dateDesc = Date().description
        let firstIdx = dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: " ") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }
    
}
