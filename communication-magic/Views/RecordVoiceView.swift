//
//  RecordVoiceView.swift
//  VoiceDelieverApp
//
//  Created by peter wi on 3/24/22.
//

import SwiftUI

struct RecordVoiceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm: RecordVoiceViewModel
    
    @State private var showingAlert = false
    
    @State private var effect1 = false
    @State private var effect2 = false
    
    @State private var shouldGoBackToMembersList = false
    
    init(_ memberTo: Member, _ groupTo: Group, _ sendToGroup: Bool) {
        self.memberTo = memberTo
        self.groupTo = groupTo
        self.sendToGroup = sendToGroup
        _vm = ObservedObject(wrappedValue: RecordVoiceViewModel(memberTo: memberTo, groupTo: groupTo, sendToGroup: sendToGroup))
    }
    
    let memberTo: Member?
    let groupTo: Group?
    let sendToGroup: Bool?
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    
                    
                    
                    if vm.isRecording {
                        recordIndicator
                            .frame(height: 100)
                    } else {
                        Text(vm.uploadStatus)
                            .frame(height: 100)
                    }
                    
                    Spacer()
                    
                    recordButton
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Back")
                        }
                    }
                }
                .navigationTitle((vm.sendToGroup ? vm.groupTo?.groupName : vm.memberTo?.name) ?? "unknown")
            .navigationBarTitleDisplayMode(.inline)
            }
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
                .scaleEffect(effect2 ? 2 : 0.8)
                .opacity(effect2 ? 0.3 : 1)
                
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color(#colorLiteral(red: 0.4157493109, green: 0.8572631, blue: 0.9686274529, alpha: 0.4940355314)))
                .scaleEffect(effect2 ? 3 : 0.5)
                .opacity(effect2 ? 0.2 : 0.5)
                
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                .scaleEffect(effect2 ? 1.3 : 1)
                .opacity(effect2 ? 0.8 : 1)
            
            
            Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: 45))
                .onTapGesture {
                    if vm.isRecording == true {
                        vm.stopRecording()
                        withAnimation(.default) {
                            self.effect2.toggle()
                        }
                    } else {
                        vm.startRecording()
                        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).speed(0.3)) {
                            self.effect2.toggle()
                        }
                    }
                }
        }
    }
}

struct RecordVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RecordVoiceView(Member(uid: "uid", name: "name", role: "doc", online: true), Group(groupName: "groupname"), true)
    }
}
