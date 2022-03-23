//
//  ClinicalCommunication.swift
//  communication-magic
//
//  Created by George Andrade on 3/5/22.
//

import Foundation
import SwiftUI
import Firebase

@main
struct ClinicalCommunication: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
