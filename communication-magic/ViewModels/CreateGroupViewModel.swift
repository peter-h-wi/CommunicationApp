//
//  CreateGroupViewModel.swift
//  communication-magic
//
//  Created by George Andrade on 4/5/22.
//

import Foundation

final class CreateGroupViewModel: ObservableObject {
    @Published var newGroup: Group
    @Published var allMembers = [Member]() 
    @Published var membersToAdd = [Member]()
    @Published var checkedArray: [Bool] = []
    @Published var groupName: String
    private var currentMember: Member?

    init(groupName: String) {
        self.groupName = groupName
        newGroup = Group(groupName: "")
        fetchAllUsers()
    }
        
    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("Members")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch users: \(error)")
                    return
                }

                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let member = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online:"] as? Bool ?? false))
                    if member.uid != FirebaseManager.shared.auth.currentUser?.uid { //fixes duplicating ourself onto list view
                        self.allMembers.append(member)
                        self.checkedArray.append(false)
                    }
                    else {
                        self.currentMember = member
                    }
                })
            }
    }
        
    func createGroup() {
        newGroup.groupName = self.groupName
        newGroup.members = membersToAdd
        newGroup.members.append(self.currentMember!)
        
        var membersIds = [String]()
        for member in newGroup.members {
            membersIds.append(member.id)
        }
        
        let userData = ["uid": newGroup.uid, "groupName": newGroup.groupName, "membersIds": membersIds, "isFavorite:": newGroup.isFavorite, "activeMessages": [String]()] as [String : Any]
        FirebaseManager.shared.firestore.collection("Groups")
            .document(newGroup.uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    print("Failed to store group in groups")
                    return
                }
                print("Successfully stored group in groups")
            }
    }
    
    func handleMemberSelction(member: Member) -> Void {
        if membersToAdd.contains(member) {
            if var index = membersToAdd.firstIndex(of: member) {
                membersToAdd.remove(at: index)
                index = allMembers.firstIndex(of: member)!
                checkedArray[index] = false
            }
        } else {
            membersToAdd.append(member)
            let index = allMembers.firstIndex(of: member)!
            checkedArray[index] = true
        }
    }
}
