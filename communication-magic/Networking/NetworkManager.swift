//
//  NetworkManager.swift
//  communication-magic
//
//  Created by George Andrade on 3/22/22.
//

import Foundation

struct NetworkManager {
    static func get<T: Decodable>(url: URL, responseType: T.Type, urlSession: URLSession = .shared) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await urlSession.data(for: request)
        let response = try JSONDecoder().decode(responseType, from: data)
        return response
    }
    
    static func post<T: Decodable>(url: URL, body: [String : Any], responseType: T.Type, urlSession: URLSession = .shared) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await urlSession.data(for: request)
        let response = try JSONDecoder().decode(responseType, from: data)
        return response
    }
}
