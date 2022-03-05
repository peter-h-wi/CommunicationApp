//
//  NotAnsweredView.swift
//  communication-magic
//
//  Created by peter wi on 3/2/22.
//

import SwiftUI

struct NotAnsweredView: View {
    var body: some View {
        NavigationView {
            Text("Message")
                .navigationTitle("Not Answered Messages")
        }
    }
}

struct NotAnsweredView_Previews: PreviewProvider {
    static var previews: some View {
        NotAnsweredView()
    }
}
