//
//  Member.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct Member: Identifiable, Codable, Equatable {
    let uid: String
    let name: String
    let role: String
    var online: Bool 
    
    var id: String {
        uid
    }
}
