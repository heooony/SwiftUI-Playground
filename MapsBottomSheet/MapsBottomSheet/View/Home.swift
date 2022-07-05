//
//  Home.swift
//  MapsBottomSheet
//
//  Created by 김동헌 on 2022/07/05.
//

import SwiftUI
import MapKit

struct Home: View {
    @State var searchText = ""
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var latitude = 37.404882
    @State var longitude = 127.105943
    @GestureState var gestureOffset: CGFloat = 0
    var body: some View {
        ZStack {
            Text("Bottom Sheet Test!!")
            
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView (
                    ZStack {
                        BlurView(style: .systemUltraThinMaterial)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        VStack {
                            Capsule()
                                .fill(.white.opacity(0.6))
                                .frame(width: 60, height: 4)
                                .padding(.top)
                            SongsList()
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(
                        DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        })
                        .onEnded({ value in
                            let maxHeight = height - 100
                            withAnimation {
                                if -offset > 100 && -offset < maxHeight / 2 {
                                    offset = -(maxHeight / 3)
                                }
                                else if -offset > maxHeight / 2 {
                                    offset = -maxHeight
                                }
                                else {
                                    offset = 0
                                }
                            }
                            lastOffset = offset
                        })
                    )
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 5
    }
    
    @ViewBuilder
    func SongsList() -> some View {
        VStack(spacing: 25) {
            ForEach(albums) { album in
                HStack(spacing: 12) {
                    Text("#\(getIndex(album: album) + 1)")
                        .fontWeight(.semibold)
                    
                    Image(album.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(album.albumName)
                            .fontWeight(.semibold)
                        
                        Label {
                            Text("65,178,909")
                        } icon: {
                            Image(systemName: "beats.headphones")
                        }
                        .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: album.isLiked ?
                              "suit.heart.fill" : "suit.heart")
                        .font(.title3)
                        .foregroundColor(album.isLiked ? .red : .primary)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.primary)
                    }
                }
            }
        }
        .padding(.top, 10)
    }
    
    // MARK: Album Index
    func getIndex(album: Album) -> Int {
        return albums.firstIndex { CAlbum in
            CAlbum.id == album.id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
