//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by 김동헌 on 2022/07/28.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView {
            ForEach(0 ..< 10) { _ in
                FeedCell()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
