//
//  CommentViewModel.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CommentViewModel: ObservableObject {
    private let db = Firestore.firestore()
    @Published var commentList: [SingleCommentModel]?
    @Published var commentListIsCompleted: Bool? = false
    @Published var errorMessage: String = ""

    func fetchComments(documentName: String) {
        let docRef = db.collection("comments").document(documentName).collection("comments")
        docRef.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                print("Error getting stories: \(error.localizedDescription)")
                return
            }
            let comments = snapshot?.documents.compactMap { document in
                try? document.data(as: SingleCommentModel.self)
            } ?? []
            DispatchQueue.main.async {
                self.commentList = comments
                self.commentListIsCompleted = true
            }
        }
    }

    func addComments(documentName: String, userName: String, timestamp: Int, comment: String) {
        let docRef = db.collection("comments").document(documentName).collection("comments").document()
        let singleComment = SingleCommentModel(userId: userName.toAsciiCode(), userName: userName, timestamp: timestamp, comment: comment)

        do {
            try docRef.setData(from: singleComment)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
    }

    func deleteComment(timestamp: Int, documentName: String) {
        let docRef = db.collection("comments").document(documentName).collection("comments")
        docRef.whereField("timestamp", isEqualTo: timestamp).getDocuments { snapshot, _ in
            if let snapshot = snapshot?.documents {
                for doc in snapshot {
                    // Do delete
                    docRef.document(doc.documentID).delete { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                            self.fetchComments(documentName: documentName)
                        }
                    }
                }
            }
        }
    }

    func reportComment(singleComment: ReportCommentModel) {
        let docRef = db.collection("reports").document()

        do {
            try docRef.setData(from: singleComment)
        } catch let error {
            print("Error writing report comment to Firestore: \(error)")
        }
    }

    func clearName(name: String) -> String {
        var returnStr = ""
        returnStr = name.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
        returnStr = returnStr.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        returnStr = returnStr.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        return returnStr
    }
}

// docRef.document(doc.documentID).updateData([
//    "userName": FieldValue.delete(),
//    "userId": FieldValue.delete(),
//    "timestamp": FieldValue.delete(),
//    "comment": FieldValue.delete(),
