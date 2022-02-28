//
//  GroupModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

struct GroupModel: Identifiable, Hashable {
    static func == (lhs: GroupModel, rhs: GroupModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    
    var group_name: String = ""
    var members: [MemberModel] = []
    var active_messages: [MessageModel] = []
    var is_favorite: Bool = false
}
