//
//  DefaultMembers.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import Foundation

enum MemberList {
    static let defaultMembers = [
        Member(id: UUID(),
               username: "bluebird",
               first_name: "Mark",
               last_name: "Zerk",
               occupation: "Nurse",
               profile_img_address: "bluebird"),
        Member(id: UUID(),
               username: "amyyy",
               first_name: "Amy",
               last_name: "Roberts",
               occupation: "Nurse",
               profile_img_address: "amy"),
        Member(id: UUID(),
               username: "gillie",
               first_name: "Brian",
               last_name: "Gil",
               occupation: "Technician",
               profile_img_address: "brian"),
        Member(id: UUID(),
               username: "tommy",
               first_name: "Tom",
               last_name: "Hanks",
               occupation: "Nurse",
               profile_img_address: "tom"),
        Member(id: UUID(),
               username: "sooony",
               first_name: "Sonny",
               last_name: "Son",
               occupation: "Nurse",
               profile_img_address: "son"),
        Member(id: UUID(),
               username: "dorii",
               first_name: "Doria",
               last_name: "Rohani",
               occupation: "Nurse",
               profile_img_address: "doria"),
        Member(id: UUID(),
               username: "lupeng",
               first_name: "Lupeng",
               last_name: "Shi",
               occupation: "Doctor",
               profile_img_address: "lupeng"),
        Member(id: UUID(),
               username: "oliver",
               first_name: "Oliver",
               last_name: "Sam",
               occupation: "Pharmacist",
               profile_img_address: "oliver")
    ]
}

extension Member {
    static let example = Member(id: UUID(),
                                username: "Johny",
                                first_name: "John",
                                last_name: "Doe",
                                occupation: "Doctor",
                                profile_img_address: "John")
}

