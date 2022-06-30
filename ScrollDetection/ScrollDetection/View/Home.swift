//
//  Home.swift
//  ScrollDetection
//
//  Created by 김동헌 on 2022/06/29.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            Text("Historical letters")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .padding(.top, 25)
                .padding(.bottom, 30)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(letters) { letter in
                        LetterCardView(letter: letter)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            // setting coordinate name space
            .coordinateSpace(name: "SCROLL")
        }
        .frame(width: .infinity, height: .infinity)
        .background(
            Text("No More Letters")
                .font(.title.bold())
                .foregroundColor(.gray)
        )
        .background(
            Color.black.opacity(0.05)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct LetterCardView: View {
    
    var letter: Letter
    
    // ScrollOffset
    // Retreiving whole scroll frame
    @State var rect: CGRect = .zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                Text(letter.date)
                    .font(.title2.bold())
                
                Text(letter.title)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(width: .infinity, alignment: .leading)
            
            Divider()
                .padding(.vertical, 10)
            
            Text("텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다. 텍스트 테스트용 문구입니다.")
                .lineSpacing(11)
                .multilineTextAlignment(.leading)
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            Color.white.cornerRadius(6)
        )
        // masking view to show like the letter is shrinking
        .mask(
            Rectangle()
                .padding(.top, rect.minY < (getIndex() * 50) ? -(rect.minY - getIndex() * 50) : 0)
        )
        // applying offset to show shirnking from bottom
        .offset(y: rect.minY < (getIndex() * 50) ? (rect.minY - (getIndex() * 50)) : 0)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
        // stop backward scrolling
        // why we stopped scrolling here
        .overlay(
            ScrolledLetterShape()
            ,alignment: .top
        )
        // separating each card at a distance of 50
        .offset(y: rect.minY < (getIndex() * 50) ? -(rect.minY - (getIndex() * 50)) : 0)
        .modifier(OffsetModifier(rect: $rect))
        // applying bottom padding for last letter to allow scrolling
        .padding(.bottom, isLast() ? rect.height : 0)
    }
    
    @ViewBuilder
    func ScrolledLetterShape() -> some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 30 * getProgress())
            .overlay(
                Rectangle()
                    .fill(
                        .linearGradient(.init(colors: [
                            Color.black.opacity(0.1),
                            Color.clear,
                            Color.black.opacity(0.1),
                            Color.black.opacity(0.05)
                        ]), startPoint: .top, endPoint: .bottom)
                    )
                , alignment: .top
            )
            .cornerRadius(6)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
    }
    
    func isLast() -> Bool {
        return letters.last == letter
    }
    
    func getIndex() -> CGFloat {
        let index = letters.firstIndex { letter in
            return self.letter.id == letter.id
        } ?? 0
        return CGFloat(index)
    }
    
    func getProgress() -> CGFloat {
        let progress = -rect.minY / rect.height
        return (progress > 0 ? (progress < 1 ? progress : 1) : 0)
    }
}
