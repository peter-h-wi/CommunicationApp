//
//  MembersViewModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

final class MembersViewModel: ObservableObject {
    @Published var groups = GroupList.defaultGroups
    @Published var member: Member?
    @Published var members = [Member]()
    @Published var isUserCurrentlyLoggedOut = false

    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        FirebaseManager.shared.firestore.collection("Members").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user:", error)
                return
            }

            guard let data = snapshot?.data() else {
                print("No data found")
                return

            }
            let uid = data["uid"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let role = data["role"] as? String ?? ""
            let online = data["online"] as? Bool ?? false
            self.member = Member(uid: uid, name: name, role: role, online: online)
        }
    }
    
    private func fetchAllUsers() {
            FirebaseManager.shared.firestore.collection("users")
                .getDocuments { documentsSnapshot, error in
                    if let error = error {
                        print("Failed to fetch users: \(error)")
                        return
                    }

                    documentsSnapshot?.documents.forEach({ snapshot in
                        let data = snapshot.data()
                        let member = Member(uid: data["uid"] as! String, name: data["name"] as! String, role: data["role"] as! String, online: (data["online"] != nil))
          //              if member.uid != FirebaseManager.shared.auth.currentUser?.uid {
            //                self.members.append(.init(data: data))
              //          }

                    })
                }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
     //   try? FirebaseManager.shared.auth.signOut() this should be done here, lets see if it doesnt break anything later
    }
    
    func getFavoriteGroups() -> [Group] {
        return groups.filter { group in
            return group.is_favorite == true
        }
    }
    
    func getAllGroups() -> [Group] {
        return groups
    }
    
}
