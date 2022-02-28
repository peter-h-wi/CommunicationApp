//
//  MyInfoModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

struct MyInfoModel: Identifiable {
    let id = UUID()
    let name: String
    let login_id: String
    let status: Bool = false
}
