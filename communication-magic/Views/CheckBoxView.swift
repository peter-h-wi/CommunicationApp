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
    let onSelect: () -> Void

    var body: some View {
        Button(action: { onSelect() }) {
            HStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                Spacer()
                Image(systemName: checked ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                    .frame(width: 30)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.primary)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(title: "title here", checked: true) {
            print("something")
        }
    }
}
