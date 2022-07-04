//
//  StaggeredGrid.swift
//  StaggeredGridApp
//
//  Created by 김동헌 on 2022/07/04.
//

import SwiftUI

// Custom View Builder
// T -> is to hold the identifiable collection of data

struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    var list: [T]
    // It will return each object from collection to build view
    var content: (T) -> Content
    
    // properties
    var showIndicators: Bool
    var spacing: CGFloat
    
    // Columns
    var columns: Int
    
    init(showIndicators: Bool = false, spacing: CGFloat = 10, list: [T], columns: Int, @ViewBuilder content: @escaping (T) -> Content) {
        self.list = list
        self.content = content
        self.spacing = spacing
        self.showIndicators = showIndicators
        self.columns = columns
    }
    
    // Staggered Grid Function
    func setUpList() -> [[T]] {
        
        // creating empty sub arrays of columns count
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        // spiliting array for VStack oriented view
        var currentIndex: Int = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            
            // increasing index count
            // and resstting if overbounds the columns count
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showIndicators) {
            HStack(alignment: .top) {
                ForEach(setUpList(), id: \.self) { columnsData in
                    // for optimized using LazyStack
                    LazyVStack(spacing: spacing) {
                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                }
            }
        }
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
