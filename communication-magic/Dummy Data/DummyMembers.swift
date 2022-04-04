//
//  DummyMembers.swift
//  communication-magic
//
//  Created by George Andrade on 4/2/22.
//

import Foundation
enum MemberList {
    static let allMembers = [
        Member(uid: "fwefew", name: "bluebird", role: "nurse", online: false),
        Member(uid: "fwfwe", name: "amy", role: "nurse", online: false),
        Member(uid: "fweffwefweew", name: "brian", role: "technician", online: false),
        Member(uid: "qq", name: "tom", role: "nurse", online: false),
        Member(uid: "fwvsdefew", name: "son", role: "nurse", online: false),
        Member(uid: "fwefefefew", name: "doria", role: "nurse", online: false),
        Member(uid: "fewf", name: "lupeng", role: "doctor", online: false),
        Member(uid: "qwq", name: "oliver", role: "pharmacist", online: false),
        Member(uid: "fwecvdsvfew", name: "mark", role: "nurse", online: false),
        Member(uid: "fweczcdasfew", name: "donald", role: "nurse", online: false),
        Member(uid: "adaw", name: "tim", role: "pharmacist", online: false),
        Member(uid: "fwefgrgfew", name: "lauren", role: "doctor", online: false),
        Member(uid: "qwqwf", name: "bri", role: "nurse", online: false),
        Member(uid: "fefe", name: "santana", role: "technician", online: false),
        Member(uid: "fwegregrefew", name: "harry", role: "front desk", online: false),
        Member(uid: "ghhtr", name: "min", role: "front desk", online: false),
    ]
    static let nurseMembers = [
        Member(uid: "htrhrt", name: "bluebird", role: "nurse", online: false),
        Member(uid: "fwefhrthrew", name: "amy", role: "nurse", online: false),
        Member(uid: "rwe", name: "tom", role: "nurse", online: false),
        Member(uid: "fwefwrewew", name: "son", role: "nurse", online: false),
        Member(uid: "ytry", name: "doria", role: "nurse", online: false),
        Member(uid: "uyt", name: "mark", role: "nurse", online: false),
        Member(uid: "qrwq", name: "donald", role: "nurse", online: false),
        Member(uid: "ege", name: "bri", role: "nurse", online: false),
    ]
    static let doctorMembers = [
        Member(uid: "gd", name: "lupeng", role: "doctor", online: false),
        Member(uid: "fes", name: "lauren", role: "doctor", online: false),
    ]
    static let technicianMembers = [
        Member(uid: "fse", name: "brian", role: "technician", online: false),
        Member(uid: "fes", name: "santana", role: "technician", online: false),
    ]
    static let pharmacistMembers = [
        Member(uid: "tre", name: "oliver", role: "pharmacist", online: false),
        Member(uid: "yeyr", name: "tim", role: "pharmacist", online: false),
    ]
    static let frontDeskMembers = [
        Member(uid: "tret", name: "harry", role: "front desk", online: false),
        Member(uid: "terte", name: "min", role: "front desk", online: false),
    ]
    static let individual1 = [
        Member(uid: "rfew", name: "amy", role: "nurse", online: false),
    ]
    static let individual2 = [
        Member(uid: "fwe", name: "brian", role: "technician", online: false),
    ]
    static let individual3 = [
        Member(uid: "wwf", name: "oliver", role: "pharmacist", online: false),
    ]
    static let individual4 = [
        Member(uid: "fwef", name: "tim", role: "pharmacist", online: false),
    ]
    static let individual5 = [
        Member(uid: "gre", name: "min", role: "front desk", online: false),
    ]
    static let individual6 = [
        Member(uid: "qdwq", name: "harry", role: "front desk", online: false),
    ]
    static let individual7 = [
        Member(uid: "greg", name: "lupeng", role: "doctor", online: false),
    ]
    static let individual8 = [
        Member(uid: "qdwq", name: "lauren", role: "doctor", online: false),
    ]
    static let individual9 = [
        Member(uid: "gre", name: "donald", role: "nurse", online: false),
    ]
    static let individual10 = [
        Member(uid: "dqw", name: "son", role: "nurse", online: false),
    ]
}

extension Member {
    static let example = Member(uid: "fwefwe", name: "john", role: "technician", online: true)
}
