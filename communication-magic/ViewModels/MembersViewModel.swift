//
//  MembersViewModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation
import AVFoundation
import Firebase

final class MembersViewModel: ObservableObject {
    @Published var groups = [Group]()
    @Published var member: Member? //current user, maybe rename this variable later
    @Published var members = [Member]() //starts off with empty array of type member
    @Published var memberTo: Member?
    @Published var groupTo: Group?
    @Published var sendToGroup: Bool?
    @Published var isUserCurrentlyLoggedOut = false
    
    @Published var messageArray: [Message] = []
    
    var messageListener: ListenerRegistration?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
        fetchAllUsers()
        fetchMyGroups()
        resetMessages()
        fetchMessages()
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
    
    func fetchAllUsers() {
        if !members.isEmpty {
            members = []
        }
            FirebaseManager.shared.firestore.collection("Members")
                .getDocuments { documentsSnapshot, error in
                    if let error = error {
                        print("Failed to fetch users: \(error)")
                        return
                    }

                    documentsSnapshot?.documents.forEach({ snapshot in
                        let data = snapshot.data()
                        let member = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online"] as? Bool ?? false))
                        if member.uid != FirebaseManager.shared.auth.currentUser?.uid { //fixes duplicating ourself onto list
                            self.members.append(member)
                        }
                    })
                }
    }
    
    func fetchMyGroups() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        if !groups.isEmpty {
            groups = []
        }
        FirebaseManager.shared.firestore.collection("Groups")
            .getDocuments { documentsSnapshot, error in
                if let error = error {
                    print("Failed to fetch groups: \(error)")
                    return
                }

                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    if case let membersIds as [String] = data["membersIds"] {
                        var allMembers = [Member]()
                        for id in membersIds {
                            FirebaseManager.shared.firestore.collection("Members")
                                .getDocuments { documentsSnapshot, error in
                                    if let error = error {
                                        print("Failed to fetch users: \(error)")
                                        return
                                    }

                                    documentsSnapshot?.documents.forEach({ snapshot in
                                        let data = snapshot.data()
                                        let member = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online"] as? Bool ?? false))
                                        if id == data["uid"] as! String {
                                            allMembers.append(member)
                                        }
                                    })
                                }
                            if id == uid { //fixes duplicating ourself onto list
                                self.groups.append(Group(uid: data["uid"] as? String ?? "", groupName: data["groupName"] as? String ?? "", members: allMembers, isFavorite: data["isFavorite"] as? Bool ?? false, activeMessages: []))
                            }
                        }
                    }
                })
            }
        
    }
    
    func resetMessages() {
        // resetMessages
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        FirebaseManager.shared.firestore
            .collection("Messages")
            .document(uid)
            .collection("Messages")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        FirebaseManager.shared.firestore
                            .collection("Messages")
                            .document(uid)
                            .collection("Messages")
                            .document(document.documentID)
                            .delete() {
                                err in
                                    if let err = err {
                                        print("Error removing document: \(err)")
                                    } else {
                                        print("User message document successfully removed!")
                                    }
                            }
                    }
                }
            }
    }
    
    func fetchMessages() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
                
        messageListener = FirebaseManager.shared.firestore
            .collection("Messages")
            .document(uid)
            .collection("Messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Failed to listen for messages: \(error)")
                    return
                }
                
                // only changes
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        do {
                            let data = try change.document.data(as: Message.self)
                            // play audio
                            AudioService.shared.startPlaying(url: data.audioURL)
                            print("Successfully added message")
                        } catch {
                            print(error)
                        }
                    }
                })
            }
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
     //   try? FirebaseManager.shared.auth.signOut() this should be done here, lets see if it doesnt break anything later
        messageListener?.remove()
    }
    
    func getFavoriteGroups() -> [Group] {
        return groups.filter { group in
            return group.isFavorite == true
        }
    }
    
    func getAllGroups() -> [Group] {
        return groups
    }
    
}
