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
                    Text("My Groups")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.groups) { group in
                        Button {
                            vm.groupTo = group
                            vm.sendToGroup = true
                            shouldShowRecordingScreen.toggle()
                        } label: {
                            HStack {
                                Circle()
                                    .frame(width: 25, height: 25)
                                VStack{
                                    Text(group.groupName)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                    Divider()
                    Text("Members")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.members) { member in
                        Button {
                            vm.memberTo = member
                            vm.sendToGroup = false
                            shouldShowRecordingScreen.toggle()
                        } label: {
                            HStack {
                                Circle()
                                    .frame(width: 25, height: 25)
                                VStack{
                                    Text(member.name)
                                        .font(.headline)
                                    Text(member.role)
                                        .font(.body)
                                }
                                Spacer()
                                Circle().foregroundColor(.green)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $shouldShowRecordingScreen) {
                RecordVoiceView(vm.memberTo ?? Member(uid: "", name: "", role: "", online: false), vm.groupTo ?? Group(groupName: ""), vm.sendToGroup ?? true)
            }
        }
    }
    
    private var customNavBar: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.member?.name ?? "noname")
                    .font(.system(size: 24, weight: .bold))
                Text(vm.member?.role ?? "norole")
                    .font(.system(size: 16, weight: .medium))

                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }

            }
            Spacer()
            Button {
                shouldShowCreateGroups.toggle()
            } label: {
                Image(systemName: "plus.app.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }

            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
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
        .fullScreenCover(isPresented: $shouldShowCreateGroups) {
            CreateGroupView()
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView(vm: MembersViewModel())
    }
}
