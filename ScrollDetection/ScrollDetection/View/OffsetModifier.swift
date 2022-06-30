//
//  OffsetModifier.swift
//  ScrollDetection
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var rect: CGRect
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy in
                    Color
                        .clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }
            )
            .onPreferenceChange(OffsetKey.self) { value in
                self.rect = value
            }
    }
}

// Offset Preference Key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
