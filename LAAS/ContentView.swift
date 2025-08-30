//
//  ContentView.swift
//  LAAS
//
//  Created by Sophie Lin 
//

import SwiftUI

struct ContentView: View {
    var adasQuestionItems = AdasQuestionItems()
    let persistenceController = PersistenceController.shared
    @State private var focusModeOn = false
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection)  {
            HomeView(tabSelection: $tabSelection).tabItem {
                Text("Home")
                Image(systemName: "house")
            }
            .tag(1)
            ProfileView(tabSelection: $tabSelection).tabItem {
                Text("Profile")
                Image(systemName: "person.circle")
            }
            .tag(2)
            ARGuidedView(tabSelection: $tabSelection).tabItem {
                Text("LungAus")
                Image(systemName: "lungs.fill")
            }
            .tag(3)
            BreathRecView(tabSelection: $tabSelection).tabItem {
                Text("BreathRec")
                Image(systemName: "recordingtape")
            }
            .tag(4)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ReportView(tabSelection: $tabSelection).tabItem {
                Text("Report")
                Image(systemName: "book")
            }
            .tag(5)
        }
        .environmentObject(adasQuestionItems)
       
    }
}


struct ItemSectionHeader: View {
    let symbolSystemName: String
    let headerText: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolSystemName)
            Text(headerText)
        }
        .font(.title3)
        .foregroundColor(Color("AccentColor"))
    }
}

struct ItemRow: View {
    let item: ADItem
    
    var body: some View {
        VStack {
            if item.isComplete {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text(item.name)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                HStack {
                    Image(systemName: "square")
                    Text(item.name)
                }
            }
        }
    }
}

struct CdrsbItemRow: View {
    let item: CdrsbItem
    
    var body: some View {
        VStack {
            if item.isComplete {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text(item.name)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            } else {
                HStack {
                    Image(systemName: "square")
                    Text(item.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let adasQuestionItems = AdasQuestionItems()
        
        Group {
            ContentView(adasQuestionItems: adasQuestionItems)
            ContentView(adasQuestionItems: adasQuestionItems)
                .preferredColorScheme(.dark)
        }
    }

}

