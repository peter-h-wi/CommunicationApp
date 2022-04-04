//
//  Member.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct Member: Identifiable, Codable {
    let uid: String
    let name: String
    let role: String
    let online: Bool 
    
    var id: String {
        uid
    }
}
