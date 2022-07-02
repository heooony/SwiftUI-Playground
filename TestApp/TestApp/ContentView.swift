//
//  ContentView.swift
//  TestApp
//
//  Created by 김동헌 on 2022/07/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Color.blue.frame(width: .infinity, height: 60)
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .global)
                    let width = frame.width
                    let height = frame.height
                    let sizeWidth = proxy.size.width
                    let sizeHeight = proxy.size.height
                    
                    VStack(alignment: .leading) {
                        Text("width: \(width)")
                        Text("height: \(height)")
                        Text("sizeWidth: \(sizeWidth)")
                        Text("sizeHeight: \(sizeHeight)")
                    }
                }
            }
            .background(.green)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
