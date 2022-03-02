//
//  ChatsViewModel.swift
//  communication-magic
//
//  Created by peter wi on 3/2/22.
//

import Foundation

final class ChatsViewModel: ObservableObject {
    @Published var groups = GroupList.defaultGroups
    
    func getAllGroups() -> [GroupModel] {
        return groups
    }
}
