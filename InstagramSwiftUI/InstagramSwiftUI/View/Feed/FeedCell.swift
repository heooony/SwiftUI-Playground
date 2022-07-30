//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by 김동헌 on 2022/07/29.
//

import SwiftUI

struct FeedCell: View {
    var body: some View {
        VStack(alignment: .leading) {
            // user info
            HStack {
                Image("profile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .cornerRadius(18)
                
                Text("heo___ney")
                    .font(.system(size: 14, weight: .semibold))
            }
            
            // post image
            Image("post")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 400)
                .clipped()
            
            // action buttons
            HStack(spacing: 8) {
                
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .font(.system(size: 20))
                        .padding(4)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .font(.system(size: 20))
                        .padding(4)
                }

            }
            .foregroundColor(.black)
            
            // caption
            HStack {
                
                Text("test")
                    .font(.system(size: 14, weight: .semibold))
                +
                Text("노을이 보이는 해안가, 여기서는 모든 것이 옳게 보이기도 한다. 마음을 진정시켜 세상을 보자")
                    .font(.system(size: 15))
               
            }
            
            Text("2d")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.top)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell()
    }
}
