//
//  CustomStackView.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/06/30.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
    var titleView: Title
    var contentView: Content
    
    // offsets
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    
    init(@ViewBuilder titleView: @escaping () -> Title, @ViewBuilder contentView: @escaping () -> Content) {
        self.titleView = titleView()
        self.contentView = contentView()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .font(.callout)
                .lineLimit(1)
                // Max height
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .background(.ultraThinMaterial)
                // .background(in: CustomCorner(corners: [.topLeft, .topRight], radius: 12))
                // 위 주석과 같은 의미로 사용되는것이 .mask
                .mask(CustomCorner(corners: bottomOffset < 38 ? .allCorners: [.topLeft, .topRight], radius: 12))
                .zIndex(1)
            
            VStack {
                Divider()
                
                contentView
                    .padding()
                    
            }
            .background(.ultraThinMaterial, in: CustomCorner(corners: [.bottomLeft, .bottomRight], radius: 12))
            // moving content upward
            .offset(y: topOffset >= 120 ? 0 : -(-topOffset + 120))
            .zIndex(0)
            .clipped()
            .opacity(getOpacity())
            
        }
        .preferredColorScheme(.dark)
        .cornerRadius(12)
        .opacity(getOpacity())
        // Stopping View @120
        .offset(y: topOffset >= 120 ? 0 : -topOffset + 120)
        .background(
            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let maxY = proxy.frame(in: .global).maxY
                DispatchQueue.main.async {
                    self.topOffset = minY
                    // redhcing - 120
                    self.bottomOffset = maxY - 120
                    // thus we will get our title height 38
                    
                }
                return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: $bottomOffset))
    }
    //opacity
    func getOpacity() -> CGFloat {
        if bottomOffset < 28 {
            let progress = bottomOffset / 28
            return progress
        }
        return 1
    }
}

struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// to avoid this creating new modifier
struct CornerModifier: ViewModifier {
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        if bottomOffset < 38 {
            content
        } else {
            content
                .cornerRadius(12)
        }
    }
}
