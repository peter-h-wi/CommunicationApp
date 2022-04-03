//
//  RecordVoiceView.swift
//  VoiceDelieverApp
//
//  Created by peter wi on 3/24/22.
//

import SwiftUI

struct RecordVoiceView: View {
    @ObservedObject var vm = VoiceViewModel()
        
    @State private var showingList = false
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false

    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    alertButton
                    
                    Spacer()
                    
                    Text("CO-Voice")
                        .foregroundColor(.primary)
                        .font(.system(size: 20 , weight : .bold))
                    
                    Spacer()
                    
                    recordListButton
                        .sheet(isPresented: $showingList, content: {
                        RecordingListView()
                    })
                }
                
                Spacer()
                Text(vm.uploadStatus)
                    .bold()
                
                if vm.isRecording {
                    recordIndicator
                }
                
                Spacer()
                
                recordButton
                
                Spacer()
                
            }
            .padding(.leading,25)
            .padding(.trailing,25)
            .padding(.top , 70)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    private var alertButton: some View {
        Button(action: {
            showingAlert = true
        }) {
            Image(systemName: "info.circle.fill")
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .bold))
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Hi There !"), message: Text("Use CO-Voice to Learn the code and Implementations . Enjoy the Code and ask me anything on my socials media"), dismissButton: .default(Text("Got it")))
        }
    }
    
    private var recordListButton: some View {
        Button(action: {
            if vm.isRecording == true {
                vm.stopRecording()
            }
            vm.fetchAllRecording()
            showingList.toggle()
        }) {
            Image(systemName: "list.bullet")
                .foregroundColor(.primary)
                .font(.system(size: 20, weight: .bold))
        }
    }
    
    private var recordIndicator: some View {
        VStack(alignment : .leading , spacing : -5){
            HStack (spacing : 3) {
                Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                    .font(.system(size:10))
                    .foregroundColor(.red)
                Text("Rec")
            }
            Text(vm.timer)
                .font(.system(size:60))
                .foregroundColor(.white)
        }
    }
    private var recordButton: some View {
        ZStack {
            Circle()
                .frame(width: 70, height: 70)
                .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
                .onAppear(){
                    self.effect2.toggle()
                }
            
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                .onAppear(){
                    self.effect1.toggle()
                }
            
            
            Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: 45))
                .onTapGesture {
                    if vm.isRecording == true {
                        vm.stopRecording()
                    } else {
                        vm.startRecording()
                        
                    }
                }
        }
    }
}

struct RecordVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RecordVoiceView()
    }
}
