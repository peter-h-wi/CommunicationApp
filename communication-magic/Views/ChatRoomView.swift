//
//  ChatRoomView.swift
//  communication-magic
//
//  Created by peter wi on 4/21/22.
//

import SwiftUI

struct ChatRoomView: View {
    @ObservedObject var vm: ChatRoomViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if vm.isGroup {
                Text("Members")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.receiverGroup.members, id: \.id) { member in
                            VStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                Text(member.name)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button {
                // record
            } label: {
                Image(systemName: "mic.circle.fill")
            }
            
        }
        .navigationTitle(vm.receiverName)
    }
}

struct ChatRoomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatRoomView(vm: ChatRoomViewModel())
        }
    }
}
