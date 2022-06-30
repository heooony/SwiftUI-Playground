//
//  Letter.swift
//  ScrollDetection
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

struct Letter: Identifiable, Hashable {
    var id = UUID().uuidString
    var date: String
    var title: String
}

var letters: [Letter] = [
    Letter(date: "2022년 3월 16일", title: "나의 생일"),
    Letter(date: "2022년 5월 5일", title: "어린이 날이라서 집에서 쉰 날"),
    Letter(date: "2022년 6월 28일", title: "땡땡이 만나러 서울대 입구로 간 날")
]
