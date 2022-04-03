//
//  MembersView.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import SwiftUI

struct MembersView: View {
    @StateObject private var vm = MembersViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    MemberView(members: [.example])
                    Divider()
                    Text("Favorite Groups")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.getFavoriteGroups(), id: \.self) { group in
                        GroupListView(group: group)
                    }
                    Divider()
                    Text("All Groups")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.getAllGroups(), id: \.self) { group in
                        GroupListView(group: group)
                    }
                }
            }
            .navigationTitle("Messages")
            .toolbar {
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

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView()
    }
}
