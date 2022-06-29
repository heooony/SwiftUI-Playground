//
//  CustomShape.swift
//  Carousel
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            // 왼쪽 위의 점으로 이동
            path.move(to: CGPoint(x: 0, y: 0))
            // y만 해당 도형의 높이만큼 아래로 이동
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let midWidth = rect.width / 2
            // 너비 절반의 -80만큼 x이동, y는 유지
            path.addLine(to: CGPoint(x: midWidth - 80, y: rect.height))
            // 위 상태에서 x += 10, y -= 25
            path.addLine(to: CGPoint(x: midWidth - 70, y: rect.height - 25))
            // 위 상태에서 x += 140, y 유지
            path.addLine(to: CGPoint(x: midWidth + 70, y: rect.height - 25))
            // 위 상태에서 x += 10, y + 25
            path.addLine(to: CGPoint(x: midWidth + 80, y: rect.height))
            // 해당 도형의 오른쪽 맨 아래로 이동
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            // 해당 도형의 오른쪽 맨 위로 이동
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
