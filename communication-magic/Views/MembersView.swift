//
//  MembersView.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import SwiftUI

struct MembersView: View {
    @ObservedObject private var vm = MembersViewModel()
    @State var shouldShowLogOutOptions = false
    @State var shouldShowRecordingScreen = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    customNavBar
                    Divider()
                    Text("Favorite Groups")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.getFavoriteGroups(), id: \.self) { group in
                        Button {
                            shouldShowRecordingScreen.toggle()
                        } label: {
                            HStack {
                                HStack(spacing: 0) {
                                    VStack(spacing:0) {
                                        Circle()
                                            .frame(width: 25, height: 25)
                                        Circle()
                                            .frame(width: 25, height: 25)
                                    }
                                    VStack(spacing:0) {
                                        Circle()
                                            .frame(width: 25, height: 25)
                                        Circle()
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                Text(group.group_name)
                                    .font(.headline)
                                Spacer()
                                Text("3/10")
                                    .frame(width: 50, height: 50)
                                    .background(Circle().foregroundColor(.green))
                            }
                        }
                    }
                    Divider()
                    Text("All Groups")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    ForEach(vm.getAllGroups(), id: \.self) { group in
                        Button {
                            shouldShowRecordingScreen.toggle()
                        } label: {
                            HStack {
                                HStack(spacing: 0) {
                                    VStack(spacing:0) {
                                        Circle()
                                            .frame(width: 25, height: 25)
                                        Circle()
                                            .frame(width: 25, height: 25)
                                    }
                                    VStack(spacing:0) {
                                        Circle()
                                            .frame(width: 25, height: 25)
                                        Circle()
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                Text(group.group_name)
                                    .font(.headline)
                                Spacer()
                                Text("3/10")
                                    .frame(width: 50, height: 50)
                                    .background(Circle().foregroundColor(.green))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Messages")
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $shouldShowRecordingScreen) {
                RecordVoiceView()
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
            }, true)
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView()
    }
}
