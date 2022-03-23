//
//  MembersViewModel.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

final class MembersViewModel: ObservableObject {
    @Published var groups = GroupList.defaultGroups
    
    init() {
        Task {
            await test()
        }
    }
    
    func getFavoriteGroups() -> [GroupModel] {
        return groups.filter { group in
            return group.is_favorite == true
        }
    }
    
    func getAllGroups() -> [GroupModel] {
        return groups
    }
    
    func test() async {
        do {
            let ans = try await NetworkService.getMessages()
            print(ans + "Test")
        } catch (let error){
            print(error.localizedDescription)
        }
        
    }
}
