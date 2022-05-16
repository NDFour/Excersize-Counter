//
//  PlusButton.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct PlusButton: View {
    
//    // MARK: CoreData
//    @Environment(\.managedObjectContext)
//    private var viewContext
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
//    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    @StateObject
    var dashboardVM: DashboardViewModel
    
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    @Binding
    var excersizeSelected: Int
    
    var body: some View {
        HStack {
            ForEach(excersizeTypeUtil.excersizes[excersizeSelected].plusButton, id: \.self) { plus in
                Button("+ \(plus)") {
                    print("+ \(plus)")
                    
                    dashboardVM.add(count: plus, type: excersizeTypeUtil.excersizes[excersizeSelected].code)
                    
                }
            }
        }
    }
    
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(dashboardVM: DashboardViewModel(), excersizeTypeUtil: ExcersizeTypeUtil(), excersizeSelected: .constant(0))
    }
}
