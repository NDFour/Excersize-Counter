//
//  AnalyseSummaryCount.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import SwiftUI

struct AnalyseSummaryCount: View {
    
    @StateObject
    var analyseVM: AnalyzseViewModel
    
    var body: some View {
        HStack {
            Text("\(analyseVM.getDaysExcersized()) Days")
                .font(.largeTitle)
                .bold()
            .padding()
            
            Text("\(analyseVM.totalRecords.count) Records")
            
            Text("\(analyseVM.totalCount) Total")
        }
    }
}

struct AnalyseSummaryCount_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseSummaryCount(analyseVM: AnalyzseViewModel())
    }
}
