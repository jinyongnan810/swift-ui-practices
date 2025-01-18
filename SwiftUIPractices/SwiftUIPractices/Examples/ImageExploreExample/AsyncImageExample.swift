//
//  AsyncImageExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/18.
//

import SwiftUI

struct AsyncImageExample: View {
    let appleURL = "https://images.pexels.com/photos/574919/pexels-photo-574919.jpeg?auto=compress&cs=tinysrgb&w=1600"

    var body: some View {
        AsyncImage(url: URL(string: appleURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case let .failure(error):
                Image(systemName: "photo").imageScale(.large)
            case let .success(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    AsyncImageExample()
}
