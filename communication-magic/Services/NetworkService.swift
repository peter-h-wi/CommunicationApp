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
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = response as? HTTPURLResponse {
            print("status = " + String(response.statusCode))
        }
        
        let str = String(decoding: data, as: UTF8.self)
        print(str)
        return str
    }
}


