//
//  AnalyseView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/14.
//

import SwiftUI

struct AnalyseView: View {
    
    @StateObject
    var analyseVM: AnalyzseViewModel = .init()
    
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    var body: some View {
        VStack {
            // MARK: Summary
            AnalyseSummaryCount(analyseVM: analyseVM)
            
            // MARK: Count by type
            AnalyseSummaryByType(analyseVM: analyseVM, excersizeTypeUtil: excersizeTypeUtil)
            
            Spacer()
        }
    }
}

struct AnalyseView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyseView(excersizeTypeUtil: ExcersizeTypeUtil())
    }
}
