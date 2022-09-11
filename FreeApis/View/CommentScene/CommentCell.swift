//
//  CommentCell.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct CommentCell: View {
    let model: SingleCommentModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "person.circle").resizable().frame(width: 25, height: 25, alignment: .center)
                Text(model.userName).font(.system(size: 14)).bold()
                Spacer()
            }
            Text(model.comment)
                .font(.system(size: 18))              .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(width: UIScreen.screenWidth)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(model: CommentModel.commentModelDummy)
    }
}
