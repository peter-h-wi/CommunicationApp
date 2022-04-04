//
//  GroupListView.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import SwiftUI

struct GroupListView: View {
    let group: Group
    var body: some View {
        if (group.members.count==1) {
            NavigationLink(destination: RecordVoiceView()) {
                HStack {
                    HStack(spacing: 0) {
                        VStack(spacing:0) {
                            Circle()
                                .frame(width: 25, height: 25)
                            Circle()
                                .frame(width: 25, height: 25)
                        }
                        VStack(spacing:0) {
                            Circle()
                                .frame(width: 25, height: 25)
                            Circle()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Text(group.group_name)
                        .font(.headline)
                    Spacer()
                    Text("3/10")
                        .frame(width: 50, height: 50)
                        .background(Circle().foregroundColor(.green))
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        } else {
            NavigationLink(destination: RecordVoiceView()) {
                HStack {
                    HStack(spacing: 0) {
                        VStack(spacing:0) {
                            Circle()
                                .frame(width: 25, height: 25)
                            Circle()
                                .frame(width: 25, height: 25)
                        }
                        VStack(spacing:0) {
                            Circle()
                                .frame(width: 25, height: 25)
                            Circle()
                                .frame(width: 25, height: 25)
                        }
                    }
                    Text(group.group_name)
                        .font(.headline)
                    Spacer()
                    Text("3/10")
                        .frame(width: 50, height: 50)
                        .background(Circle().foregroundColor(.green))
                }
            }
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView(group: Group(group_name: "test group", members: [Member(uid: "uiddd", name: "test member", role: "test role", online: true)], active_messages: [Message(id: "fwuefwf", audioURL: "audioURL", groupID: "groupID", senderID: "senderID", timestamp: Date(timeIntervalSinceReferenceDate: -12.0))], is_favorite: false))
    }
}
