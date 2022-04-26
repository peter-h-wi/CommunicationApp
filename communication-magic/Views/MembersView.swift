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
                            Image(systemName: "plus.app.fill")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                    ForEach(vm.groups) { group in
                        Button {
                            vm.groupTo = group
                            vm.sendToGroup = true
                            shouldShowRecordingScreen.toggle()
                        } label: {
                            HStack {
                                ProfileImage(imgName: "doges", width: 40)
                                VStack(alignment: .leading) {
                                    Text(group.groupName)
                                        .font(.headline)
                                }
                            }
                            .foregroundColor(.primary)
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
                                ProfileImage(imgName: "doge", width: 40)
                                VStack(alignment: .leading) {
                                    Text(member.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(member.role)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                if (member.online) {
                                    Text("online")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.green)
                                    Circle().foregroundColor(.green)
                                        .frame(width: 10, height: 10)
                                } else {
                                    Text("offline")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.red)
                                    Circle().foregroundColor(.red)
                                        .frame(width: 10, height: 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
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
            ProfileImage(imgName: "profile8", width: 50)
            VStack(alignment: .leading, spacing: 4) {
                Text(vm.member?.name ?? "noname")
                    .font(.headline)
                Text(vm.member?.role ?? "norole")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()

            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                VStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.headline)
                    Text("Sign Out")
                        .font(.caption)
                }
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


struct ProfileImage: View {
    let imgName: String
    let width: CGFloat
    
    var body: some View {
        Image(imgName)
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: width, height: width)
            .overlay(Circle().stroke(.background, lineWidth: 2))
    }
}
