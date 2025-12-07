//
//  ImageExploreExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct ImageExploreExample: View {
    var body: some View {
        List {
            NavigationLink("ContentMode", destination: ScaleFitOrFill())
            NavigationLink("Scroll", destination: ScrollThroughImages())
            NavigationLink("AsyncImage", destination: AsyncImageExample())
            NavigationLink("LazyVGrid", destination: LazyVGridExample())
            NavigationLink("ClipImage", destination: ClipImagePractice())
        }
        .navigationTitle("Explore Image")
    }
}

#Preview {
    NavigationStack {
        ImageExploreExample()
    }
}
