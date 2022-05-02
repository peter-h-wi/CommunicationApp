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
    @Published var fromName: String?
    @Published var isUserCurrentlyLoggedOut = false
    
    @Published var messages: [Message] = []
    
    var messageListener: ListenerRegistration?
    var membersListener: ListenerRegistration?
    var groupsListener: ListenerRegistration?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
        fetchAllUsers()
        fetchMyGroups()
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
            let online = data["online:"] as? Bool ?? false
            self.member = Member(uid: uid, name: name, role: role, online: online)
        }
    }
    
    func fetchAllUsers() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        if !members.isEmpty {
            members = []
        }

        membersListener = FirebaseManager.shared.firestore
            .collection("Members")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Failed to listen for members: \(error)")
                    return
                }
                
                // only changes
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        let member = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online:"] as? Bool ?? false))
                        if member.uid == uid {
                            return
                        }
                        self.members.append(member)
                        print("Successfully added new member")
                        
                    } else if change.type == .modified {
                        print("detected modification")
                        let data = change.document.data()
                        let updatedMember = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online:"] as? Bool ?? false))
                        if updatedMember.uid == uid {
                            return
                        }
                        if let index = self.members.firstIndex(where: {$0.uid == updatedMember.uid}) {
                            print("index found")
                            self.members[index] = updatedMember
                        }
                        print("Successfully updated online status")
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
        
        groupsListener = FirebaseManager.shared.firestore
            .collection("Groups")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Failed to listen for members: \(error)")
                    return
                }
                
                // only changes
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
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
                                            let member = Member(uid: data["uid"] as? String ?? "", name: data["name"] as? String ?? "noname", role: data["role"] as? String ?? "norole", online: (data["online:"] as? Bool ?? false))
                                            if id == data["uid"] as! String {
                                                allMembers.append(member)
                                            }
                                        })
                                        if id == uid { //fixes duplicating ourself onto list
                                            self.groups.append(Group(uid: data["uid"] as? String ?? "", groupName: data["groupName"] as? String ?? "", members: allMembers, isFavorite: data["isFavorite"] as? Bool ?? false, activeMessages: []))
                                        }
                                    }
                            }
                        }
                    }
                })
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
                                if data?.senderID == uid {
                                    return
                                }
                                
                                if data?.timestamp ?? DateFormatter().date(from: "01-01-1900")! < Date().addingTimeInterval(-600) {
                                    return
                                }
                                // play audio
                                AudioService.shared.startPlaying(url: data?.audioURL ?? "")
                                self.messages.append(data ?? Message(id: "", audioURL: "", groupID: "", senderID: "", timestamp: DateFormatter().date(from: "01-01-1900")!))
                                print("Successfully added message")
                            } catch {
                                print(error)
                            }
                        }
                    })
                }
        }
    
    func deleteRecordingFromFireStore(url : String) {
            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
                print("Could not find firebase uid")
                return
            }

            FirebaseManager.shared.firestore
                .collection("Messages")
                .document(uid)
                .collection("Messages")
                .whereField("audioURL", isEqualTo: url)
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                            print("User message document successfully removed!")
                        }
                    }
                }
        }

    func deleteMessage(message: Message) {
        self.messages.remove(at: self.messages.firstIndex(of: message)!)
    }
    
    func fetchUser(uid: String) -> String {
        for member in members {
            if (uid == member.uid) {
                return member.name
            }
        }
        for group in groups {
            if (uid == group.uid) {
                return group.groupName
            }
        }
        if (uid == member?.uid) {
            return member?.name ?? ""
        }
        return ""
    }
    
    func handleSignOut() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        FirebaseManager.shared.firestore
            .collection("Members")
            .document(uid)
            .updateData([
                "online:": false
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        messageListener?.remove()
        membersListener?.remove()
        groupsListener?.remove()
        member?.online = false
        self.members = []
        self.messages = []
        self.groups = []
        isUserCurrentlyLoggedOut.toggle()
     //   try? FirebaseManager.shared.auth.signOut() this should be done here, lets see if it doesnt break anything later
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
