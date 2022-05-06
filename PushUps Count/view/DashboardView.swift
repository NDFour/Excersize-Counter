//
//  DashboardView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI

struct DashboardView: View {
    
    // MARK: CoreData
    @Environment(\.managedObjectContext)
    private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var excersizeRecordsCD: FetchedResults<ExcersizeCD>
    
    let excersizeTypeUtil = ExcersizeTypeUtil()
    @State
    var excersizeSelected: Int = 0
    
    var body: some View {
        VStack {
            // MARK: Total count
            Text("Today: \(calcTotalCount(type: "pushups"))")
                .font(.largeTitle)
                .bold()
                .padding()
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
                                Text("\(calcCoundOfType(type: excersizeTypeUtil.excersizes[idx].code))")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                            }
                        }
                        .frame(width: 78, height: 78)
                    }
                }
            }
            Divider()
                .padding()
            // MARK: plus button
            HStack {
                ForEach(excersizeTypeUtil.excersizes[excersizeSelected].plusButton, id: \.self) { plus in
                    Button("+ \(plus)") {
                        print("+ \(plus)")
                        let newExcersize = ExcersizeCD(context: viewContext)
                        newExcersize.count = Int16(plus)
                        newExcersize.timestamp = Date()
                        newExcersize.type = excersizeTypeUtil.excersizes[excersizeSelected].code
                        saveCoreData()
                    }
                }
            }
            // MARK: excersize record list
            if (excersizeRecordsCD.count == 0) {
                Text("今天还没有记录，快点开始锻炼吧！")
                    .padding()
            }
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
                        Text(excersize.timestamp?.description ?? "nil")
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
    
    // MARK: Calculate total count
    private func calcTotalCount(type: String) -> Int {
        var total = 0
        for cc in excersizeRecordsCD {
            total += Int(cc.count)
        }
        return total
    }
    
    // MARK: Calculate count of some type of excersize
    private func calcCoundOfType(type: String) -> Int {
        var total = 0
        for cc in excersizeRecordsCD {
            if cc.type == type {
                total += Int(cc.count)
            }
        }
        return total
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



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
