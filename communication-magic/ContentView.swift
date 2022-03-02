//
//  ContentView.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MembersView()
                .tabItem {
                    Label("Members", systemImage: "person")
                }
            ChatsView()
                .tabItem {
                    Label("Chats", systemImage: "text.bubble")
                }
            NotAnsweredView()
                .tabItem {
                    Label("Reply", systemImage: "archivebox")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
