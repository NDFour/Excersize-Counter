//
//  ImportFromJson.swift
//  PushUps Count
//
//  Created by mac on 2022/5/27.
//

import SwiftUI

struct ImportFromJson: View {
    
    @StateObject
    var importVM: ImportDataViewmodel
    
    var body: some View {
        VStack {
            Text("Paste json string below")
                .padding()
            
            TextEditor(text: $importVM.jsonStr)
            
            HStack {
                Spacer()
                Button("Import") {
                    importVM.importJsonDataAndStore()
                }
                .padding()
            }
        }
    }
}

struct ImportFromJson_Previews: PreviewProvider {
    static var previews: some View {
        ImportFromJson(importVM: ImportDataViewmodel())
    }
}
