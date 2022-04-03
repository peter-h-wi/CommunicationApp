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
            await post()
        }
    }
    
    func getFavoriteGroups() -> [Group] {
        return groups.filter { group in
            return group.is_favorite == true
        }
    }
    
    func getAllGroups() -> [Group] {
        return groups
    }
    
    func test() async {
        do {
            let ans = try await NetworkService.getMessages()
            print(ans)
        } catch (let error){
            print(error.localizedDescription)
        }
        
    }
    
    func post() async {
        do {
            let ans = try await NetworkService.postMessages()
            print(ans)
        } catch (let error){
            print(error.localizedDescription)
        }
        
    }
}
