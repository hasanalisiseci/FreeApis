//
//  ListItemView.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct ListItemView: View {
    /// Api item model
    let model: Entry

    var body: some View {
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
                Image(systemName: "square.grid.3x3.fill")
                    .font(.title3)
            }
            Text(model.entryDescription)
                .font(.body)
            HStack(spacing: 20) {
                VStack {
                    Text("Auth")
                        .bold()
                    Text(model.auth.rawValue == "" ? "NO" : model.auth.rawValue)
                }
                Rectangle().frame(width: 2, height: 30)
                VStack {
                    Text("HTTPS")
                        .bold()
                    Text(model.https ? "YES" : "NO")
                }
                Rectangle().frame(width: 2, height: 30)
                VStack {
                    Text("CORS")
                        .bold()
                    Text(model.cors.rawValue)
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.screenWidth - 70)
        .padding(30)
        .background(Color.blue.cornerRadius(20))
        .contextMenu {
            Link(destination: URL(string: model.link) ?? URL(string: "https://api.publicapis.org/")!) {
                Text("Open Link")
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
            }
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(model: Entry.dummyEntry)
    }
}
