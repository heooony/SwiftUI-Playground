//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by 김동헌 on 2022/07/28.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedView()
            SearchView()
            UploadPostView()
            NotificationsView()
            ProfileView()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
