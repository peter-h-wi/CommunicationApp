//
//  MessageModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

struct MessageModel: Identifiable, Codable {
    let id = UUID()
    let audio_url: String
    let sender_name: String
    let timestamp: String
    let received_flag = false
    let group_id: String
    let group_name: String
}
