//
//  DummyMembers.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation
enum MemberList {
    static let allMembers = [
        Member(name: "bluebird", role: "nurse"),
        Member(name: "amy", role: "nurse"),
        Member(name: "brian", role: "technician"),
        Member(name: "tom", role: "nurse"),
        Member(name: "son", role: "nurse"),
        Member(name: "doria", role: "nurse"),
        Member(name: "lupeng", role: "doctor"),
        Member(name: "oliver", role: "pharmacist"),
        Member(name: "mark", role: "nurse"),
        Member(name: "donald", role: "nurse"),
        Member(name: "tim", role: "pharmacist"),
        Member(name: "lauren", role: "doctor"),
        Member(name: "bri", role: "nurse"),
        Member(name: "santana", role: "technician"),
        Member(name: "harry", role: "front desk"),
        Member(name: "min", role: "front desk")
    ]
    static let nurseMembers = [
        Member(name: "bluebird", role: "nurse"),
        Member(name: "amy", role: "nurse"),
        Member(name: "tom", role: "nurse"),
        Member(name: "son", role: "nurse"),
        Member(name: "doria", role: "nurse"),
        Member(name: "mark", role: "nurse"),
        Member(name: "donald", role: "nurse"),
        Member(name: "bri", role: "nurse"),
    ]
    static let doctorMembers = [
        Member(name: "lupeng", role: "doctor"),
        Member(name: "lauren", role: "doctor"),
    ]
    static let technicianMembers = [
        Member(name: "brian", role: "technician"),
        Member(name: "santana", role: "technician")
    ]
    static let pharmacistMembers = [
        Member(name: "oliver", role: "pharmacist"),
        Member(name: "tim", role: "pharmacist"),
    ]
    static let frontDeskMembers = [
        Member(name: "harry", role: "front desk"),
        Member(name: "min", role: "front desk")
    ]
    static let individual1 = [
        Member(name: "amy", role: "nurse"),
    ]
    static let individual2 = [
        Member(name: "brian", role: "technician"),
    ]
    static let individual3 = [
        Member(name: "oliver", role: "pharmacist"),
    ]
    static let individual4 = [
        Member(name: "tim", role: "pharmacist"),
    ]
    static let individual5 = [
        Member(name: "min", role: "front desk")
    ]
    static let individual6 = [
        Member(name: "harry", role: "front desk"),
    ]
    static let individual7 = [
        Member(name: "lupeng", role: "doctor"),
    ]
    static let individual8 = [
        Member(name: "lauren", role: "doctor"),
    ]
    static let individual9 = [
        Member(name: "donald", role: "nurse"),
    ]
    static let individual10 = [
        Member(name: "son", role: "nurse"),
    ]
}

extension Member {
    static let example = Member(name: "john", role: "technician")
}
