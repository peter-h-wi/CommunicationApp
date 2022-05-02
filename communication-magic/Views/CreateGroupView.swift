//
//  CreateGroupView.swift
//  communication-magic
//
//  Created by George Andrade on 4/5/22.
//

import SwiftUI

struct CreateGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm = CreateGroupViewModel(groupName: "")
    @State var shouldReturnToHome = false
    var countOfChecked = 0
    @State private var showingEmptyNameAlert = false
    @State private var showingEmptyMemberAlert = false
    let profiles = ["doctor1", "doctor2", "doctor3", "doctor4", "doctor5", "nurse1", "nurse2", "nurse3", "nurse4", "nurse5", "profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "doge"]

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.membersToAdd.reversed(), id: \.id) { member in
                            VStack {
                                ZStack {
                                    ProfileImage(imgName: profiles[(member.name.count*2 + member.role.count*3) % 19], width: 40)
                                    Button {
                                        withAnimation {
                                            vm.handleMemberSelction(member: member)
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                    }
                                    .foregroundStyle(.primary, .secondary)
                                    .offset(x:12, y:-12)

                                }
                                Text(member.name)
                                    .font(.caption)
                                    .truncationMode(.tail)
                            }
                            .frame(width: 50, height: 65)
                        }
                    }
                }
                HStack {
                    Text("Group Name")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(width: 80, alignment: .leading)
                    TextField("Group Name", text: $vm.groupName)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
                Divider()
                Text("Members")
                    .font(.headline)
                    .foregroundColor(.secondary)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(vm.allMembers) { member in
                            CheckBoxView(title: member.name, checked: vm.checkedArray[vm.allMembers.firstIndex(of: member)!], profileImg: profiles[(member.name.count*2 + member.role.count*3) % 19], onSelect: {
                                vm.handleMemberSelction(member: member)
                            })
                        }
                    }
                }
            }
            .padding()
            .fullScreenCover(isPresented: $shouldReturnToHome) {
                HomeView()
            }
            .alert("Group name can't be empty", isPresented: $showingEmptyNameAlert) {
                Button("OK", role: .cancel) { }
            }
            .alert("Members can't be empty", isPresented: $showingEmptyMemberAlert) {
                Button("OK", role: .cancel) { }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if vm.groupName == "" {
                            showingEmptyNameAlert.toggle()
                            return
                        }
                        
                        if vm.membersToAdd.isEmpty {
                            showingEmptyMemberAlert.toggle()
                            return
                        }
                        vm.createGroup()
                        shouldReturnToHome.toggle()
                    } label: {
                        HStack {
                            Text("Save")
                        }
                    }
                }
            }
            .navigationTitle("Create New Group")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
