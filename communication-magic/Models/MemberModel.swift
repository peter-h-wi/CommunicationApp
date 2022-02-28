//
//  Member.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import Foundation

struct MemberModel: Identifiable, Hashable {
    let id = UUID()
    
    let name: String
    let role: String
    let status: Bool = false
    let profile_pic_address: String
}
