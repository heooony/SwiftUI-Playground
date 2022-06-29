//
//  Home.swift
//  Carousel
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

struct Home: View {
    @State var selectedTab: Trip = trips[0]
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Image(selectedTab.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height, alignment: .center)
                    .cornerRadius(0)
                    .blur(radius: 10.0)
                    .background(.black)
            }
            .ignoresSafeArea()
            
            VStack {
                Text("Let's Go With")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Pocotrip")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                VStack {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        
                        TabView(selection: $selectedTab) {
                            ForEach(trips) { trip in
                                Image(trip.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: frame.width - 10, height: frame.height
                                           , alignment: .center)
                                    .cornerRadius(4)
                                    .tag(trip)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    Text(selectedTab.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.bottom, 18)
                    
                    PageControl(maxPages: trips.count, currentPage: getIndex())
                    
                }
                .padding(.top)
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .background(Color.white.clipShape(CustomShape()).cornerRadius(10))
                .padding(.horizontal, 20)
                
                Button {
                    
                } label: {
                    Text("GET STARTED")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
                .padding(.horizontal)

            }
            .padding()
        }
    }
    
    func getIndex() -> Int {
        let index = trips.firstIndex { (trip) -> Bool in
            return selectedTab.id == trip.id
        } ?? 0
        
        return index
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
