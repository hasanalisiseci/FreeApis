//
//  CommentViewHeaderView.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct CommentHeaderView: View {
    /// Api item model
    let model: Entry

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(model.api.uppercased())
                            .font(.title)
                            .bold()
                        Rectangle().frame(width: 50, height: 2)
                    }
                    Spacer()
                    Text(model.category)
                        .font(.title3)
                        .multilineTextAlignment(.trailing)
                }
                Text(model.entryDescription)
                    .font(.body)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            .foregroundColor(.white)
            .frame(width: UIScreen.screenWidth)
            .background(Color.blue)
        }.padding(.top, -20)
    }
}

struct CommentViewHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CommentHeaderView(model: Entry.dummyEntry)
    }
}
