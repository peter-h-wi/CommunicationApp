//
//  ChatRoomViewModel.swift
//  communication-magic
//
//  Created by peter wi on 4/21/22.
//

import Foundation

final class ChatRoomViewModel: ObservableObject {
    @Published var receiverMember = Member.example
    @Published var receiverGroup = Group.example
    @Published var isGroup = false
    
    @Published var recordSecCount = 0
    
    let audioService = AudioService.shared
    
    var receiverName: String {
        isGroup ? receiverGroup.groupName : receiverMember.name
    }
    
    func updateReceivers(group: Group) {
        receiverGroup = group
        isGroup = true
    }
    
    func updateReceivers(member: Member) {
        receiverMember = member
        isGroup = false
    }
    
    func startRecording() {
        
    }
    
    func stopRecording() {
        
    }
    
    
}
