//
//  AnalyseSummaryByType.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import SwiftUI

struct AnalyseSummaryByType: View {
    
    @StateObject
    var analyseVM: AnalyzseViewModel
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    
    var body: some View {
        HStack {
            ForEach(0 ..< excersizeTypeUtil.excersizes.count) { idx in
                VStack {
                    ZStack {
                        Image("\(excersizeTypeUtil.excersizes[idx].image)")
                            .resizable()
                            .frame(width: 50, height: 50)

                        HStack {
                            Spacer()
                            VStack {
                                Text("\(analyseVM.calcCountOfType(type: excersizeTypeUtil.excersizes[idx].code))")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }
                        }
                        .frame(width: 78, height: 78)
                    }
                    // MARK: Max count
                    let maxEx = analyseVM.getMax(of: excersizeTypeUtil.excersizes[idx].code)
                    if maxEx.max > 0 {
                        Text("Max: \(maxEx.max)")
                        Text("\(DateFormatUtil.getDateString(from: maxEx.date))")
                            .font(.subheadline)
                            .opacity(0.4)
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct AnalyseSummaryByType_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseSummaryByType(analyseVM: AnalyzseViewModel(), excersizeTypeUtil: ExcersizeTypeUtil())
    }
}
