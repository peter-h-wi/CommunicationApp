//
//  GroupListView.swift
//  communication-magic
//
//  Created by peter wi on 2/28/22.
//

import SwiftUI

struct GroupListView: View {
    let group: GroupModel
    var body: some View {
        if (group.members.count==1) {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(group.members[0].name)
                        .font(.headline)
                    Text(group.members[0].role)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("ON")
                    .frame(width: 50, height: 50)
                    .background(Circle().foregroundColor(.green))
            }
        } else {
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

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView(group: GroupModel.example)
    }
}
