//
//  Home.swift
//  StaggeredGridApp
//
//  Created by 김동헌 on 2022/07/04.
//

import SwiftUI

struct Home: View {
    @State var posts: [Post] = []
    // to show dynamic
    @State var columns: Int = 2
    // Smooth Hero Effect
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            StaggeredGrid(list: posts, columns: columns, content: { post in
                // post card view
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
                    .onAppear {
                        print(post.imageURL)
                    }
            })
            .padding(.horizontal)
            .navigationTitle("Staggered Grid")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns += 1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        columns = max(columns - 1, 1)
                    } label: {
                        Image(systemName: "minus")
                    }
                }
            }
            .animation(.easeOut, value: columns)
        }
        .onAppear {
            for index in 1...15 {
                posts.append(Post(imageURL: "post\(index)"))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// since we declared T as Identifiable
// so we need to pass Identifiable conform collection/Array

struct PostCardView: View {
    var post: Post
    var body: some View {
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
