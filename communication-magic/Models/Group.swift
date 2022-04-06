//
//  Group.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct Group: Identifiable, Codable {
    var uid: String = UUID().uuidString
    var groupName: String
    var members: [Member] = []
    var isFavorite: Bool = false
    var activeMessages: [Message] = []
    
    var id: String {
        uid
    }
}
