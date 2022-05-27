//
//  ImportDataView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/25.
//

import SwiftUI

struct ImportDataView: View {
    
    @StateObject
    var importVM: ImportDataViewmodel = .init()
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil = .init()
    
    var body: some View {
        TabView {
            ImportFromTxt(importVM: importVM, excersizeTypeUtil: excersizeTypeUtil)
                .tabItem {
                    Text("Text")
                }
            
            ImportFromJson(importVM: importVM)
                .tabItem {
                    Text("Json")
                }
        }
    }
}

struct ImportDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImportDataView()
    }
}
