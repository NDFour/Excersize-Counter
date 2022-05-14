//
//  ContentView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink {
                        DashboardView()
                    } label: {
                        Text("Today")
                    }
                    
                    NavigationLink {
                        Text("Page Analyse")
                    } label: {
                        Text("Analyse")
                    }
                    
                    NavigationLink {
                        RecordsView(selectedDate: Date())
                    } label: {
                        Text("Records")
                    }
                    
                }
                Text(getTodayDate())
                    .font(.subheadline)
                    .padding()
            }
            VStack {
//                Text("Go for the training")
//                    .font(.largeTitle)
                Image("excersize-now")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
            }
        }

    }
    
    
    // MARK: Get today's date
    private func getTodayDate() -> String {
        let d1 = Date()
        // let timeZone = TimeZone.current
        let timeZone = TimeZone(identifier: "Asia/Shanghai") ?? TimeZone.current
        let interval: Int = timeZone.secondsFromGMT(for: d1)
        let currentDate = d1.addingTimeInterval(Double(interval))
        
        let dateDesc = currentDate.description
        let firstIdx = dateDesc.startIndex
        let secondIdx = dateDesc.lastIndex(of: " ") ?? dateDesc.endIndex
        let rel = dateDesc[firstIdx ..< secondIdx]
        return String(rel)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
