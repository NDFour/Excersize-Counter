//
//  ContentView.swift
//  PushUps Count
//
//  Created by mac on 2022/5/5.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    DashboardView()
                } label: {
                    Text("Dashboard")
                }
                
                NavigationLink {
                    Text("Page Analyse")
                } label: {
                    Text("Analyse")
                }
                
                NavigationLink {
                    RecordsView(selectedDate: Date())
                } label: {
                    Text("Records")
                }
            }
            VStack {
//                Text("Go for the training")
//                    .font(.largeTitle)
                Image("excersize-now")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
            }
        }

    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
