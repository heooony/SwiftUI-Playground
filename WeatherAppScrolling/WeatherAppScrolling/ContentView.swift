//
//  ContentView.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Since Window is decrepted in iOS 15
        // Getting safe area using GeometryReader
        GeometryReader { proxy in
            let topEdge = proxy.safeAreaInsets.top
            Home(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
