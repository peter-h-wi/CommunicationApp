//
//  DummyGroups.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation

enum GroupList {
    static let defaultGroups: [Group] = [
        /*
        Group(group_name: "All Members", members: MemberList.allMembers),
        Group(group_name: "Nurse", members: MemberList.nurseMembers, is_favorite: true),
        Group(group_name: "Doctor", members: MemberList.doctorMembers),
        Group(group_name: "Technician", members: MemberList.technicianMembers),
        Group(group_name: "Pharmacist", members: MemberList.pharmacistMembers),
        Group(group_name: "Front Desk", members: MemberList.frontDeskMembers, is_favorite: true),
        Group(group_name: MemberList.individual1[0].name, members: MemberList.individual1),
        Group(group_name: MemberList.individual2[0].name, members: MemberList.individual2, is_favorite: true),
        Group(group_name: MemberList.individual3[0].name, members: MemberList.individual3),
        Group(group_name: MemberList.individual4[0].name, members: MemberList.individual4, is_favorite: true),
        Group(group_name: MemberList.individual5[0].name, members: MemberList.individual5),
        Group(group_name: MemberList.individual6[0].name, members: MemberList.individual6),
        Group(group_name: MemberList.individual7[0].name, members: MemberList.individual7),
        Group(group_name: MemberList.individual8[0].name, members: MemberList.individual8),
        Group(group_name: MemberList.individual9[0].name, members: MemberList.individual9, is_favorite: true),
        Group(group_name: MemberList.individual10[0].name, members: MemberList.individual10) */
    ]
}

extension Group {
    static let example = Group(uid: "myGroupID", groupName: "myGroupName", members: MemberList.nurseMembers, isFavorite: true)
}
