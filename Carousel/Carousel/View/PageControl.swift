//
//  PageControl.swift
//  Carousel
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

// UIViewRepresentable
// SwiftUI에서 UIKit을 SwiftUI에 맞게 wrapping해주는 프로토콜
// makeUIView와 updateUIView 함수를 추가해주어야 한다.
struct PageControl: UIViewRepresentable {
    
    var maxPages: Int
    var currentPage: Int
    
    // makeUIView
    // UIView를 생성하는 메소드로, SwiftUI의 View 라이프 사이클 동안 한번만 호출된다.
    // wrapping하고자 하는 UIView를 여기서 생성하여 return하면 된다.
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.backgroundStyle = .minimal
        control.numberOfPages = maxPages
        control.currentPage = currentPage
        
        return control
    }
    
    // updateUIView
    // SwiftUI View의 State가 바뀔 때마다 트리거가 된다.
    // 이 메소드 안에서 view의 정보를 업데이트 할 수 있으며, @Binding 기능을 사용하여 SwiftUI View의 상태를 가져올 수 있다.(read-only)
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
}
