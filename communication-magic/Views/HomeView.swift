//
//  HomeView.swift
//  communication-magic
//
//  Created by George Andrade on 4/3/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MembersView()
                .tabItem {
                    Label("Members", systemImage: "person")
                }
            RecordingListView(vm: RecordVoiceViewModel(memberTo: Member(uid: "", name: "", role: "", online: false), groupTo: Group(groupName: ""), sendToGroup: true))
                .tabItem {
                    Label("Recordings", systemImage: "archivebox")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
