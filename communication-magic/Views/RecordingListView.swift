//
//  RecordingListView.swift
//  VoiceDelieverApp
//
//  Created by peter wi on 3/24/22.
//
import SwiftUI

struct RecordingListView: View {
    @ObservedObject var vm: MembersViewModel
    @ObservedObject var audioService = AudioService.shared
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    Text("Playing \(audioService.numOfItems) messages")
                    ForEach(vm.messages, id: \.id) { message in
                        VoiceCardView2(message: message, vm: vm)
                            .padding()
                    }
                }
            }
            .padding(.top,30)
            .navigationBarTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(vm: MembersViewModel())
    }
}

struct VoiceCardView2: View {
    let message: Message
    @ObservedObject var vm: MembersViewModel
    let profiles = ["doctor1", "doctor2", "doctor3", "doctor4", "doctor5", "nurse1", "nurse2", "nurse3", "nurse4", "nurse5", "profile1", "profile2", "profile3", "profile4", "profile5", "profile6", "profile7", "profile8", "doge"]
    
    var body: some View {
        HStack{
            VStack {
                ProfileImage(imgName: profiles[vm.fetchUser(uid: message.senderID).count*3 % 19], width: 40)
                    .padding(.horizontal)
                Spacer()
            }
            
            VStack(alignment:.leading, spacing: 8) {
                HStack {
                    Text("From: ")
                        .frame(width: 50, alignment: .leading)
                    Text("\(vm.fetchUser(uid: message.senderID))")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("To: ")
                        .frame(width: 50, alignment: .leading)
                    Text("\(vm.fetchUser(uid: message.groupID))")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("\(message.timeAgo)")
                        .font(.caption)
                }
            }
            .foregroundColor(.white)
            Spacer()
            VStack {
                Button(action: {
                    vm.deleteRecordingFromFireStore(url: message.audioURL)
                    withAnimation {
                        vm.deleteMessage(message: message)
                    }
                }) {
                    Image(systemName:"xmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size:15))
                }
                Spacer()
                Button(action: {
                    AudioService.shared.startPlayingRightNow(url: message.audioURL)
                }) {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size:30))
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .padding(.horizontal,10)
//        .frame(width: 370, height: 85)
        .background(.secondary)
        //.background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .cornerRadius(20)
        .shadow(radius: 10)
        //.shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 10)
    }
}
