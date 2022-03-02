//
//  MembersViewModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

final class MembersViewModel: ObservableObject {
    @Published var groups = GroupList.defaultGroups
    
    func getFavoriteGroups() -> [GroupModel] {
        return groups.filter { group in
            return group.is_favorite == true
        }
    }
    
    func getAllGroups() -> [GroupModel] {
        return groups
    }
}
