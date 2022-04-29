//
//  HomeView.swift
//  communication-magic
//
//  Created by George Andrade on 4/3/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = MembersViewModel()
  
    var body: some View {
        TabView {
            MembersView(vm: vm)
                .tabItem {
                    Label("Members", systemImage: "person")
                }
            RecordingListView(vm: vm)
                .tabItem {
                    Label("Messages", systemImage: "archivebox")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
