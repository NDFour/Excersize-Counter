//
//  DatePickerBar.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct DatePickerBar: View {
    
    var startDate = Date()
    var endDate = Date().addingTimeInterval(TimeInterval())
    
    @State
    var exDays: [Date]
    @State
    var selectedDate: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0 ..< exDays.count, id: \.self) { idx in
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 40)
                            .cornerRadius(12)
                            .opacity(0.2)
                        if idx == selectedDate {
                            Rectangle()
                                .frame(width: 100, height: 40)
                                .cornerRadius(12)
                                .foregroundColor(.purple)
                                .opacity(0.2)
                        }
                        Text(getMonthAndDay(dateStr: exDays[idx]))
                            .font(.title)
                            .onTapGesture(perform: {
                                withAnimation(.linear) {
                                    selectedDate = idx
                                }
                            })
                    }
                }
            }
            .onAppear(perform: {
                _ = getDaysList()
        })
        }
    }
    
    
    private func getDaysList() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let duration = getDaysDiff(start: "2022-04-09", end: getFormatedDate(dateStr: today.description))

        let excersizeStart = calendar.date(byAdding: .day, value: -duration, to: today)!
        
        print("excersizeStart: \(excersizeStart)")

        var matchingDates = [Date]()
        // Finding matching dates at midnight - adjust as needed
        let components = DateComponents(hour: 0, minute: 0, second: 0) // midnight
        calendar.enumerateDates(startingAfter: excersizeStart, matching: components, matchingPolicy: .nextTime) { (date, strict, stop) in
            if let date = date {
                if date <= today {
                    // let weekDay = calendar.component(.weekday, from: date)
                    // print(date, weekDay)
                    matchingDates.append(date)
                } else {
                    stop = true
                }
            }
        }
        self.exDays = matchingDates
        
        return matchingDates
    }
    
    private func getDaysDiff(start: String, end: String) -> Int {
        let startDate = start.split(separator: "-").compactMap {Int($0)}
        let endDate = end.split(separator: "-").compactMap {Int($0)}
        
        guard (startDate.count >= 3 && endDate.count >= 3) else {
            print("getDaysList Error!!")
            return 0
        }
        //Maybe add a check here that both arrays are of length 2
        let startComponents = DateComponents(year: startDate[0], month: startDate[1], day: startDate[2])
        let endComponents = DateComponents(year: endDate[0], month: endDate[1], day: endDate[2])

        let days = Calendar.current.dateComponents([.day], from: startComponents, to: endComponents).day!

        return days
    }
    
    private func getFormatedDate(dateStr: String) -> String {
        let originStr = dateStr
        let secondIdx = originStr.firstIndex(of: " ") ?? originStr.endIndex
        let rel = originStr[originStr.startIndex ..< secondIdx]
        return String(rel)
    }
    
    private func getMonthAndDay(dateStr: Date) -> String {
        let yyMMdd = getFormatedDate(dateStr: dateStr.description)
        let firstIndex = yyMMdd.firstIndex(of: "-") ?? yyMMdd.startIndex
        let rel = yyMMdd[firstIndex ..< yyMMdd.endIndex]
        return String(rel)
    }
    
}

struct DatePickerBar_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerBar(exDays: [Date]())
    }
}
