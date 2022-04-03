//
//  Member.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct Member: Identifiable, Hashable {
    let id = UUID()
    
    let name: String
    let role: String
    let status: Bool = false
}
