//
//  UserInfo.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

struct UserInfo: Identifiable {
    let id = UUID()
    let name: String
    let login_id: String
    let status: Bool = false
}
