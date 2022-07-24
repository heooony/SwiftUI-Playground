//
//  BlogViewModel.swift
//  Blog
//
//  Created by 김동헌 on 2022/07/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class BlogViewModel: ObservableObject {
    
    // Posts
    @Published var posts: [Post]?
    
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    func fetchPosts() async {
        do {
            let db = Firestore.firestore().collection("Blog")
            let posts = try await db.getDocuments()
            
            self.posts = posts.documents.compactMap({ post in
                return try? post.data(as: Post.self)
            })
        }
        catch {
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
}
