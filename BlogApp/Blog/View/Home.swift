//
//  Home.swift
//  BlogApp
//
//  Created by 김동헌 on 2022/07/21.
//

import SwiftUI

struct Home: View {
    @StateObject var blogData = BlogViewModel()
    
    // Color based on ColorScheme
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack {
            if let posts = blogData.posts {
                
                if posts.isEmpty {
                    (
                        Text(Image(systemName: "rectangle.and.pencil.and.cllipsis"))
                        +
                        Text("Start Writing Blog")
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    
                } else {
                    List(posts) { post in
                        CardView(post: post)
                    }
                    .listStyle(.insetGrouped)
                }
                
            } else {
                ProgressView()
            }
        }
        .navigationTitle("My Blog")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(scheme == .dark ? Color.black : Color.white)
                    .padding()
                    .background(.primary, in: Circle())
            })
            .padding()
            .foregroundStyle(.primary)
            ,alignment: .bottomTrailing
        )
        
        // ferching Blog post
        .task {
            await blogData.fetchPosts()
        }
        .alert(blogData.alertMsg, isPresented: $blogData.showAlert) {
            
        }
    }
    
    @ViewBuilder
    func CardView(post: Post) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(post.title)
                .fontWeight(.bold)
            
            Text("Written By: \(post.author)")
                .font(.callout)
                .foregroundColor(.gray)
            
            Text("Written By: \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                .font(.caption.bold())
                .foregroundColor(.gray)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
