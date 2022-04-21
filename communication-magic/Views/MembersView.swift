//
//  MembersView.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import SwiftUI

struct MembersView: View {
    @ObservedObject var vm: MembersViewModel
    @State var shouldShowLogOutOptions = false
    @State var shouldShowRecordingScreen = false
    @State var shouldShowCreateGroups = false

    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    customNavBar
                    Divider()
                    
                    HStack {
                        Text("My Groups")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Button {
                            shouldShowCreateGroups.toggle()
                        } label: {
                            Image(systemName: "plus.app")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                    groupList
                    
                    Divider()
                    Text("Members")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    memberList
                    
                }
                .padding(.horizontal)
            }
            .navigationTitle("Messages")
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $shouldShowRecordingScreen) {
                RecordVoiceView(vm.memberTo ?? Member(uid: "", name: "", role: "", online: false), vm.groupTo ?? Group(groupName: ""), vm.sendToGroup ?? true)
            }
            .fullScreenCover(isPresented: $shouldShowCreateGroups) {
                CreateGroupView()
            }
        }
    }
    
    private var customNavBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.member?.name ?? "noname")
                    .font(.title)
                    .bold()
                Text(vm.member?.role ?? "norole")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title2)
                    .foregroundColor(.red)
            }
        }
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Sign Out"), message: Text("Do you wish to sign out?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    print("clicked signed out")
                    vm.handleSignOut()
                }),
                    .cancel()
            ])
        }
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
            LoginView({
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
                self.vm.fetchAllUsers()
                self.vm.fetchMyGroups()
                self.vm.fetchMessages()
            }, true)
        }
    }
    
    
    var groupList: some View {
        ForEach(vm.groups) { group in
            NavigationLink(destination: RecordVoiceView(vm.memberTo ?? Member(uid: "", name: "", role: "", online: false), vm.groupTo ?? Group(groupName: ""), true)) {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    VStack{
                        Text(group.groupName)
                            .font(.headline)
                    }
                }
                .foregroundColor(.primary)
            }
        }
    }
    
    var memberList: some View {
        ForEach(vm.members) { member in
            NavigationLink(destination: RecordVoiceView(vm.memberTo ?? Member(uid: "", name: "", role: "", online: false), vm.groupTo ?? Group(groupName: ""), false)) {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    VStack{
                        Text(member.name)
                            .font(.headline)
                        Text(member.role)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    if (member.online) {
                        Text("online")
                            .font(.system(size: 12))
                            .foregroundColor(Color.green)
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 10, height: 10)
                    } else {
                        Text("offline")
                            .font(.system(size: 12))
                            .foregroundColor(Color.red)
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 10, height: 10)
                    }
                }
                .foregroundColor(.primary)
            }
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView(vm: MembersViewModel())
    }
}
