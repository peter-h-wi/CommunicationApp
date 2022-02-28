//
//  DefaultMembers.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import Foundation

enum MemberList {
    static let allMembers = [
        MemberModel(name: "bluebird", role: "nurse", profile_pic_address: "bluebird"),
        MemberModel(name: "amy", role: "nurse", profile_pic_address: "amy"),
        MemberModel(name: "brian", role: "technician", profile_pic_address: "brian"),
        MemberModel(name: "tom", role: "nurse", profile_pic_address: "tom"),
        MemberModel(name: "son", role: "nurse", profile_pic_address: "son"),
        MemberModel(name: "doria", role: "nurse", profile_pic_address: "doria"),
        MemberModel(name: "lupeng", role: "doctor", profile_pic_address: "lupeng"),
        MemberModel(name: "oliver", role: "pharmacist", profile_pic_address: "oliver"),
        MemberModel(name: "mark", role: "nurse", profile_pic_address: "mark"),
        MemberModel(name: "donald", role: "nurse", profile_pic_address: "donald"),
        MemberModel(name: "tim", role: "pharmacist", profile_pic_address: "tim"),
        MemberModel(name: "lauren", role: "doctor", profile_pic_address: "lauren"),
        MemberModel(name: "bri", role: "nurse", profile_pic_address: "bri"),
        MemberModel(name: "santana", role: "technician", profile_pic_address: "santana"),
        MemberModel(name: "harry", role: "front desk", profile_pic_address: "harry"),
        MemberModel(name: "min", role: "front desk", profile_pic_address: "min")
    ]
    static let nurseMembers = [
        MemberModel(name: "bluebird", role: "nurse", profile_pic_address: "bluebird"),
        MemberModel(name: "amy", role: "nurse", profile_pic_address: "amy"),
        MemberModel(name: "tom", role: "nurse", profile_pic_address: "tom"),
        MemberModel(name: "son", role: "nurse", profile_pic_address: "son"),
        MemberModel(name: "doria", role: "nurse", profile_pic_address: "doria"),
        MemberModel(name: "mark", role: "nurse", profile_pic_address: "mark"),
        MemberModel(name: "donald", role: "nurse", profile_pic_address: "donald"),
        MemberModel(name: "bri", role: "nurse", profile_pic_address: "bri"),
    ]
    static let doctorMembers = [
        MemberModel(name: "lupeng", role: "doctor", profile_pic_address: "lupeng"),
        MemberModel(name: "lauren", role: "doctor", profile_pic_address: "lauren"),
    ]
    static let technicianMembers = [
        MemberModel(name: "brian", role: "technician", profile_pic_address: "brian"),
        MemberModel(name: "santana", role: "technician", profile_pic_address: "santana")
    ]
    static let pharmacistMembers = [
        MemberModel(name: "oliver", role: "pharmacist", profile_pic_address: "oliver"),
        MemberModel(name: "tim", role: "pharmacist", profile_pic_address: "tim"),
    ]
    static let frontDeskMembers = [
        MemberModel(name: "harry", role: "front desk", profile_pic_address: "harry"),
        MemberModel(name: "min", role: "front desk", profile_pic_address: "min")
    ]
    static let individual1 = [
        MemberModel(name: "amy", role: "nurse", profile_pic_address: "amy"),
    ]
    static let individual2 = [
        MemberModel(name: "brian", role: "technician", profile_pic_address: "brian"),
    ]
    static let individual3 = [
        MemberModel(name: "oliver", role: "pharmacist", profile_pic_address: "oliver"),
    ]
    static let individual4 = [
        MemberModel(name: "tim", role: "pharmacist", profile_pic_address: "tim"),
    ]
    static let individual5 = [
        MemberModel(name: "min", role: "front desk", profile_pic_address: "min")
    ]
    static let individual6 = [
        MemberModel(name: "harry", role: "front desk", profile_pic_address: "harry"),
    ]
    static let individual7 = [
        MemberModel(name: "lupeng", role: "doctor", profile_pic_address: "lupeng"),
    ]
    static let individual8 = [
        MemberModel(name: "lauren", role: "doctor", profile_pic_address: "lauren"),
    ]
    static let individual9 = [
        MemberModel(name: "donald", role: "nurse", profile_pic_address: "donald"),
    ]
    static let individual10 = [
        MemberModel(name: "son", role: "nurse", profile_pic_address: "son"),
    ]
}

extension MemberModel {
    static let example = MemberModel(name: "john", role: "technician", profile_pic_address: "john")
}

