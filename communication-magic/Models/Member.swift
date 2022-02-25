//
//  Member.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import Foundation

struct Member: Identifiable {
    let id: UUID
    
    let username: String
    let first_name: String
    let last_name: String
    let occupation: String
    let profile_img_address: String
}
