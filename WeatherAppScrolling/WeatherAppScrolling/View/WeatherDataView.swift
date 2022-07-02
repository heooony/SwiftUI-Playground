//
//  WeatherDataView.swift
//  WeatherAppScrolling
//
//  Created by 김동헌 on 2022/07/02.
//

import SwiftUI

struct WeatherDataView: View {
    var body: some View {
        VStack(spacing: 8) {
            CustomStackView {
                Label {
                    Text("Air Quality")
                } icon: {
                    Image(systemName: "circle.hexagongrid.fill")
                }
            } contentView: {
                VStack(alignment: .leading, spacing: 10) {
                    Text("143 - Moderately Polluted")
                        .font(.title3.bold())
                    Text("May cause breating discomfort for people with lung disease such as asthma and discomfort for people with heart disease, children and older adults.")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
            }
            HStack {
                CustomStackView {
                    Label {
                        Text("UV Index")
                    } icon: {
                        Image(systemName: "sun.mix")
                    }
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("0")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("Low")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                CustomStackView {
                    Label {
                        Text("Rainfall")
                    } icon: {
                        Image(systemName: "drop.fill")
                    }
                } contentView: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("0 mm")
                            .font(.title)
                            .fontWeight(.semibold)
                        Text("in last 24 hours")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
            }
            .frame(maxHeight: .infinity)
            
            CustomStackView {
                Label {
                    Text("10-Day Forecast")
                } icon: {
                    Image(systemName: "calendar")
                }
            } contentView: {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(forecast) { cast in
                        VStack {
                            HStack(spacing: 15) {
                                Text(cast.day)
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    // max width
                                    .frame(width: 60, alignment: .leading)
                                
                                Image(systemName: cast.image)
                                    .font(.title3)
                                    .symbolVariant(.fill)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(.yellow, .white)
                                    .frame(width: 30)
                                
                                Text("\(Int(cast.farenheit - 8))")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .foregroundStyle(.white)
                                
                                // progress bar
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(.tertiary)
                                        .foregroundStyle(.white)
                                   
                                    // for width
                                    GeometryReader { proxy in
                                        Capsule()
                                            .fill(.linearGradient(.init(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                                            .frame(width: (cast.farenheit / 140) * proxy.size.width)
                                    }
                                }
                                .frame(height: 4)
                                
                                Text("\(Int(cast.farenheit))")
                                    .font(.title3.bold())
                                    .foregroundStyle(.secondary)
                                    .foregroundStyle(.white)
                            }
                            if cast != forecast.last {
                                Divider()
                            }
                        }
                        .padding(.vertical, 0)
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDataView()
    }
}
