//
//  ScrollThroughImages.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct ScrollThroughImages: View {
    @State private var showName: Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(ImagesForExploreExample.allCases, id: \.self) { img in
                    Image(img.rawValue)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .padding()
                        .overlay {
                            if showName {
                                Text(
                                    "\(img.rawValue.replacingOccurrences(of: "img", with: ""))"
                                ).foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .shadow(color: .white, radius: 5)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showName.toggle()
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ScrollThroughImages()
}
