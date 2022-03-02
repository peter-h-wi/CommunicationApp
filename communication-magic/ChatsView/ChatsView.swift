//
//  ChatsView.swift
//  communication-magic
//
//  Created by peter wi on 3/2/22.
//

import SwiftUI

struct ChatsView: View {
    @StateObject private var vm = ChatsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    ForEach(vm.getAllGroups(), id: \.self) { group in
                        GroupListView(group: group)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Chats")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // search
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // search
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
