//
//  NetworkService.swift
//  communication-magic
//
//  Created by peter wi on 3/5/22.
//

import Foundation

struct NetworkService {
    
    static func getMessages() async throws -> String {
        let url = URL(string: "http://localhost:3000/ping")!
        let response = try await NetworkManager.get(url: url, responseType: String.self)
        return response
    }
    
    static func postMessages() async throws -> String {
        let url = URL(string: "http://localhost:3000/new")!
        let body: [String: Any] = [
            "id": "123",
            "audio_url": "placeholder",
            "sender_name":"placeholder",
            "timestamp": "placeholder",
            "received_flag": "false",
            "group_id": "placeholder",
            "group_name": "placeholder",
        ]
        let response = try await NetworkManager.post(url: url, body: body, responseType: String.self)
        return response
    }
    
}


