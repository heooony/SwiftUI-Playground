//
//  Home.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/06/30.
//

import SwiftUI

struct Home: View {
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    var body: some View {
        ZStack {
            // GeometryReader for getting height and width
            GeometryReader { proxy in
                Image("sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            // Blur material
            .blur(radius: 20)
            .background(.black)
            
            // Main view
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    // Weather data
                    VStack(alignment: .center, spacing: 5) {
                        Text("Seongnam-si")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        Text("\(Int(offset))°")
                            .font(.system(size: 60))
                            .fontWeight(.thin)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        Text("Cloudy")
                            .foregroundStyle(.secondary)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        Text("H:26° L:21°")
                            .foregroundStyle(.primary)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                    }
                    // fix view about y
                    .offset(y: -offset)
                    // for bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.height) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    // Custom data view
                    VStack(spacing: 8) {
                        CustomStackView {
                            // Label here
                            Label {
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                        } contentView: {
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) {
                                        ForecastView(time: "12 PM", celcius: 22, image: "sun.min")
                                        ForecastView(time: "1 PM", celcius: 23, image: "sun.haze")
                                        ForecastView(time: "2 PM", celcius: 24, image: "sun.min")
                                        ForecastView(time: "3 PM", celcius: 24, image: "cloud.sun")
                                        ForecastView(time: "4 PM", celcius: 22, image: "sun.haze")
                                    }
                                }
                            }
                        }
                        
                        WeatherDataView()
                    }
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                // Getting Offset
                .overlay(
                    // Using GeometryReader
                    GeometryReader { proxy -> Color in
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        return Color.clear
                    }
                )
            }
        }
    }
    
    func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    
    func getTitleOffset() -> CGFloat{
        if offset < 0 {
            // setting one max height for whole title
            // consider max as 120
            let progress = offset / 120
            
            // since top padding is 25
            let newOffset = (progress >= -1.0 ? progress : -1) * 20
            
            return newOffset
        }
        
        return 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ForecastView: View {
    
    var time: String
    var celcius: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            Image(systemName: image)
                .font(.title2)
                // Multi color
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
                // max frame
                .frame(height: 30)
            Text("\(Int(celcius))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
