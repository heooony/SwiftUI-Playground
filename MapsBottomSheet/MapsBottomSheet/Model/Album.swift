//
//  Album.swift
//  MapsBottomSheet
//
//  Created by 김동헌 on 2022/07/05.
//

import SwiftUI

struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String
    var isLiked: Bool = false
}

var albums: [Album] = [
    Album(albumName: "Positions", albumImage: "Album1"),
    Album(albumName: "The Best", albumImage: "Album2"),
    Album(albumName: "My Everything", albumImage: "Album3", isLiked: true),
    Album(albumName: "Yours Truly", albumImage: "Album4"),
    Album(albumName: "Sweetener", albumImage: "Album5"),
    Album(albumName: "Rain On Me", albumImage: "Album6", isLiked: true),
    Album(albumName: "Stuck with U", albumImage: "Album7", isLiked: true),
    Album(albumName: "7 rings", albumImage: "Album8"),
    Album(albumName: "Bang Bang", albumImage: "Album9"),
]
