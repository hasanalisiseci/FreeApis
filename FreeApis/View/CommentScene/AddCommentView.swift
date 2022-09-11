//
//  AddCommentView.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct AddCommentView: View {
    @Binding var username: String
    @Binding var comment: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                Spacer()
            }
            TextField("Comment...", text: $comment)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .frame(width: UIScreen.screenWidth, height: 40, alignment: .center)
                .font(.title2)
                .multilineTextAlignment(.leading)
        }
        .frame(width: UIScreen.screenWidth)
        .padding(20)
    }
}

struct AddCommentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCommentView(username: .constant(""), comment: .constant(""))
    }
}
