//
//  MembersView.swift
//  communication-magic
//
//  Created by peter wi on 2/23/22.
//

import SwiftUI

struct MembersView: View {
    //let members: [Member]
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    MemberView(members: [.example])
                    Divider()
                    Text("Favorite Group")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView()
    }
}
