//
//  RecordingListView.swift
//  VoiceDelieverApp
//
//  Created by peter wi on 3/24/22.
//

import SwiftUI

struct RecordingListView: View {
    @ObservedObject var vm: MembersViewModel
        
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false){
                    ForEach(vm.messages, id: \.id) { message in
                        VoiceCardView2(message: message)
                    }
//                    ForEach(vm.recordingsList, id: \.createdAt) { recording in
//                        VoiceCardView(vm: vm, recording: recording)
//                    }
                }
            }
            .padding(.top,30)
            .navigationBarTitle("Recordings")
        }
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(vm: MembersViewModel())
    }
}



struct VoiceCardView: View {
    @ObservedObject var vm: RecordVoiceViewModel
    let recording: Recording
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"headphones.circle.fill")
                    .font(.system(size:50))
                
                VStack(alignment:.leading) {
                    Text("\(recording.fileURL.lastPathComponent)")
                }
                VStack {
                    Button(action: {
                        vm.deleteRecording(url:recording.fileURL)
                    }) {
                        Image(systemName:"xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size:15))
                    }
                    Spacer()
                    
                    Button(action: {
                        if recording.isPlaying == true {
                            vm.stopPlaying(url: recording.fileURL)
                        }else{
                            vm.startPlaying(url: recording.fileURL)
                        }
                    }) {
                        Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
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

struct VoiceCardView2: View {
    let message: Message
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"headphones.circle.fill")
                    .font(.system(size:50))
                
                VStack(alignment:.leading) {
                    Text("\(message.senderID)")
                    Text("\(message.groupID)")
                    Text("\(message.timeAgo)")
                }
                VStack {
                    Button(action: {
                        // delete Recording.
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
