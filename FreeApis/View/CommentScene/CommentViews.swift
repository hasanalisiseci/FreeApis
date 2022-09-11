//
//  CommentViews.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import SwiftUI

struct CommentViews: View {
    let model: Entry
    @ObservedObject var viewModel = CommentViewModel()
    @AppStorage("username") var username: String = ""

    @State private var comment = ""
    @State private var showingAlert = false

    var body: some View {
        VStack {
            CommentHeaderView(model: model)
            Section {
                Text("Let's!, share with people what you are curious about this service or any creative ideas you have about this service.").bold().padding()
            }
            if viewModel.commentListIsCompleted ?? false {
                if (viewModel.commentList == []) {
                    Section {
                        Text("No comments yet...")
                    }
                    Spacer()
                } else {
                    List(viewModel.commentList ?? [], id: \.self) { comment in
                        CommentCell(model: comment)
                            .swipeActions {
                                Button {
                                    if comment.userId == username.toAsciiCode() {
                                        viewModel.deleteComment(timestamp: comment.timestamp, documentName: viewModel.clearName(name: model.api))
                                    } else {
                                        viewModel.reportComment(singleComment: ReportCommentModel(userId: comment.userId, userName: comment.userName, timestamp: comment.timestamp, comment: comment.comment, documentName: model.api))
                                        showingAlert = true
                                    }
                                } label: {
                                    Text(comment.userId == username.toAsciiCode() ? "Delete" : "Report")
                                }
                                .tint(comment.userId == username.toAsciiCode() ? .red : .blue)
                            }
                    }
                }
            } else {
                ProgressView()
                Spacer()
            }

            AddCommentView(username: $username, comment: $comment)
                .padding()
            HStack {
                Spacer()
                Button {
                    viewModel.addComments(documentName: viewModel.clearName(name: model.api), userName: username, timestamp: Int(Date().timeIntervalSince1970), comment: comment)
                    comment = ""
                    viewModel.fetchComments(documentName: viewModel.clearName(name: model.api))

                } label: {
                    Text("Save")
                }.buttonStyle(.bordered)
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            viewModel.fetchComments(documentName: viewModel.clearName(name: model.api))
        }
        .alert("Comment is reported!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}

struct CommentViews_Previews: PreviewProvider {
    static var previews: some View {
        CommentViews(model: Entry.dummyEntry)
    }
}
