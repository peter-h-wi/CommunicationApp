//
//  Group.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct Group: Identifiable, Hashable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    
    var group_name: String = ""
    var members: [Member] = []
    var active_messages: [Message] = []
    var is_favorite: Bool = false
}
