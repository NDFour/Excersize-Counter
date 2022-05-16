//
//  ExportToJson.swift
//  PushUps Count
//
//  Created by mac on 2022/5/17.
//

import SwiftUI

struct ExportToJson: View {
    
    @StateObject
    var recordsVM: RecordsViewModel
    
    @Binding
    var showJsonSheet: Bool
    
    @State
    var jsonString = ""
    
    var body: some View {
        VStack(spacing: 12.0) {
            TextEditor(text: $jsonString)
            
            HStack {
                Spacer()
                Button("Close") {
                    withAnimation {
                        showJsonSheet = false
                    }
                }
                Button("Copy") {
                    print("Copy content of Json String...")
                }
            }
        }
        .padding()
        .onAppear(perform: {
            jsonString = recordsVM.exportToJsonString()
        })
        
    }
}

//struct ExportToJson_Previews: PreviewProvider {
//    static var previews: some View {
//        ExportToJson(showJsonSheet: .constant(true))
//    }
//}
