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
                    Text("\(audioService.numOfItems) are in the queue")
                    ForEach(vm.messages, id: \.id) { message in
                        VoiceCardView2(message: message, vm: vm)
                    }
                }
            }
            .padding(.top,30)
            .navigationBarTitle("Recordings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        audioService.updateNumOfItems()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .foregroundColor(.primary)
                }
            }
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
    
    var body: some View {
        VStack{
            HStack{
                ProfileImage(imgName: "doge", width: 40)
                
                VStack(alignment:.leading) {
                    Text("From: \(vm.fetchUser(uid: message.senderID))")
                    Text("\(message.timeAgo)")
                }
                Spacer()
                VStack {
                    Button(action: {
                        vm.deleteRecordingFromFireStore(url: message.audioURL)
                        vm.deleteMessage(message: message)
                    }) {
                        Image(systemName:"xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size:15))
                    }
                    Spacer()
                    Button(action: {
                        AudioService.shared.startPlaying(url: message.audioURL)
                    }) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.system(size:30))
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal,10)
        .frame(width: 370, height: 85)
        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        .cornerRadius(30)
        .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 10)
    }
}
