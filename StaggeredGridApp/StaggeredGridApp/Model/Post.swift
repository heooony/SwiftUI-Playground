//
//  Post.swift
//  StaggeredGridApp
//
//  Created by 김동헌 on 2022/07/04.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}
