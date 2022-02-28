//
//  DefaultGroups.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import Foundation

enum GroupList {
    static let defaultGroups = [
        GroupModel(group_name: "All Members", members: MemberList.allMembers),
        GroupModel(group_name: "Nurse", members: MemberList.nurseMembers, is_favorite: true),
        GroupModel(group_name: "Doctor", members: MemberList.doctorMembers),
        GroupModel(group_name: "Technician", members: MemberList.technicianMembers),
        GroupModel(group_name: "Pharmacist", members: MemberList.pharmacistMembers),
        GroupModel(group_name: "Front Desk", members: MemberList.frontDeskMembers, is_favorite: true),
        GroupModel(group_name: MemberList.individual1[0].name, members: MemberList.individual1),
        GroupModel(group_name: MemberList.individual2[0].name, members: MemberList.individual2, is_favorite: true),
        GroupModel(group_name: MemberList.individual3[0].name, members: MemberList.individual3),
        GroupModel(group_name: MemberList.individual4[0].name, members: MemberList.individual4, is_favorite: true),
        GroupModel(group_name: MemberList.individual5[0].name, members: MemberList.individual5),
        GroupModel(group_name: MemberList.individual6[0].name, members: MemberList.individual6),
        GroupModel(group_name: MemberList.individual7[0].name, members: MemberList.individual7),
        GroupModel(group_name: MemberList.individual8[0].name, members: MemberList.individual8),
        GroupModel(group_name: MemberList.individual9[0].name, members: MemberList.individual9, is_favorite: true),
        GroupModel(group_name: MemberList.individual10[0].name, members: MemberList.individual10)
    ]
}

extension GroupModel {
    static let example = GroupModel(group_name: "Nurse", members: MemberList.nurseMembers, is_favorite: true)
}
