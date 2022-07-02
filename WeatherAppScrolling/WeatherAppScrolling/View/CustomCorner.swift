//
//  CustomCorner.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/06/30.
//

import SwiftUI

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        // UIBezierPath : custom view에서 렌더링할 수 있는 직선 및 곡선 선분으로 구성된 path
        // 다음의 init은 특정 
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
