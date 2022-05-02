//
//  CheckBoxView.swift
//  communication-magic
//
//  Created by George Andrade on 4/5/22.
//

import SwiftUI

struct CheckBoxView: View {
    let title: String
    let checked: Bool
    let profileImg: String

    let onSelect: () -> Void


    var body: some View {
        Button(action: {
            withAnimation {
                onSelect()
            }
        }) {
            HStack {
                ProfileImage(imgName: profileImg, width: 40)
                Text(title)
                    .font(.headline)
                Spacer()
                Image(systemName: checked ? "checkmark.square" : "square")
                    .font(.headline)
                    .foregroundColor(checked ? .blue : .secondary)
            }
        }
        .foregroundColor(.primary)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(title: "title here", checked: true, profileImg: "doge") {
            print("something")
        }
    }
}
