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
        VStack {
            ExtractedView(importVM: importVM, excersizeTypeUtil: excersizeTypeUtil)
            
            Text("Paste json string below")
                .padding()
            
            TextEditor(text: $importVM.jsonStr)
            
            HStack {
                Spacer()
                Button("Import") {
                    importVM.parseStrByNewline()
                }
                .padding()
            }
        }
    }
}

struct ImportDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImportDataView()
    }
}

struct ExtractedView: View {
    @StateObject
    var importVM: ImportDataViewmodel
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    var body: some View {
        VStack {
            Text("Choose the type of your import data")
                .padding()
            HStack {
                ForEach(0 ..< excersizeTypeUtil.excersizes.count, id: \.self) { idx in
                    ZStack {
                        Image("\(excersizeTypeUtil.excersizes[idx].image)")
                            .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture(perform: {
                            withAnimation {
                                importVM.type = excersizeTypeUtil.excersizes[idx].code
                            }
                        })
                        if excersizeTypeUtil.excersizes[idx].code == importVM.type {
                            Rectangle()
                                .frame(width: 60, height: 60)
                                .opacity(0.1)
                                .cornerRadius(12)
                        }
                    }
                }
            }
        }
    }
}
