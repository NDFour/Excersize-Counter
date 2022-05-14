//
//  ExcersizeTypeTab.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct ExcersizeTypeTab: View {
    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
//    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    @StateObject
    var dashboardVM: DashboardViewModel
    
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    @Binding
    var excersizeSelected: Int
    
    var body: some View {
        // MARK: type tab
        HStack {
            ForEach(0 ..< excersizeTypeUtil.excersizes.count) { idx in
                ZStack {
                    Image("\(excersizeTypeUtil.excersizes[idx].image)")
                        .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture(perform: {
                        withAnimation {
                            excersizeSelected = idx
                        }
                    })
                    if idx == excersizeSelected {
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .opacity(0.1)
                            .cornerRadius(12)
                    }
                    HStack {
                        Spacer()
                        VStack {
                            Text("\(dashboardVM.calcCountOfType(type: excersizeTypeUtil.excersizes[idx].code))")
                                .font(.title3)
                                .bold()
                            Spacer()
                        }
                    }
                    .frame(width: 78, height: 78)
                }
            }
        }
    }
    
}

struct ExcersizeTypeTab_Previews: PreviewProvider {
    static var previews: some View {
        ExcersizeTypeTab(dashboardVM: DashboardViewModel(), excersizeTypeUtil: ExcersizeTypeUtil(), excersizeSelected: .constant(0))
    }
}
