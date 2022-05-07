//
//  ExcersizeRecordList.swift
//  PushUps Count
//
//  Created by mac on 2022/5/7.
//

import SwiftUI

struct ExcersizeRecordList: View {
    
    // MARK: CoreData
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    @State
    var excersizeTypeUtil: ExcersizeTypeUtil
    
    @State
    var formatClosure: ((_ dateDesc: String) -> String)
    
    var body: some View {
        VStack {
            List {
                ForEach(0 ..< excersizeRecordsCD.count, id: \.self) { idx in
                    let excersize = excersizeRecordsCD[idx]
                    HStack {
                        Text("\(idx + 1)")
                        if let img = excersizeTypeUtil.findImgByTypeCode(typeCode: excersize.type ?? "404") {
                            Image("\(img)")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        
                        Text(formatClosure(excersize.timestamp?.description ?? "nil"))
                        Spacer()
                        Text("+ \(excersize.count)")
                        Button(action: {
                            print("delete ...")
                            viewContext.delete(excersize)
                            saveCoreData()
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 6)
                    }
                }
            }
        }
    }
    
    // MARK: Save CoreData
    private func saveCoreData() {
        do {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        } catch {
            let error = error as NSError
            fatalError("Unresolved error: \(error)")
        }
    }
    
}

struct ExcersizeRecordList_Previews: PreviewProvider {
    static var previews: some View {
        ExcersizeRecordList(excersizeTypeUtil: ExcersizeTypeUtil()) {dateDesc in
            return "Preview"
        }
    }
}
