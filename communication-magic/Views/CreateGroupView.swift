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
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Create a new Group")
                TextField("Group Name", text: $vm.groupName)
                        .padding(5)
                Text("Select Members to add to Group")
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(vm.allMembers) { member in
                            CheckBoxView(title: member.name, checked: vm.checkedArray[vm.allMembers.firstIndex(of: member)!], onSelect: {
                                vm.handleMemberSelction(member: member)
                            })
                        }
                    }
                }
                Button {
                    if vm.groupName == "" {
                        showingAlert.toggle()
                        return
                    }
                    vm.createGroup()
                    shouldReturnToHome.toggle()
                } label: {
                    HStack {
                        Text("Submit")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                        .background(Color.blue)
                        .cornerRadius(32)
                        .padding(.horizontal)
                        .shadow(radius: 15)
                }
            }
            .background(Color(.init(white: 0, alpha: 0.05)))
            .fullScreenCover(isPresented: $shouldReturnToHome) {
                HomeView()
            }
            .alert("Group name can't be empty", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView()
    }
}
