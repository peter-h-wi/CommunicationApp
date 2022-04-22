//
//  Message.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    
    let audioURL, groupID, senderID: String
    let timestamp: Date
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()

        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
