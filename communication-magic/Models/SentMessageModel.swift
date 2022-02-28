//
//  SentMessage.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

struct SentMessageModel: Identifiable {
    let id = UUID()
    let audio_fil: String
    let group_id: String
}
