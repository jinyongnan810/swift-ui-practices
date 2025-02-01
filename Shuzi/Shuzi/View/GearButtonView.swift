//
//  GearButtonView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct GearButtonView: View {
    @Binding var showSettings: Bool
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        showSettings.toggle()
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                }
                .padding()

                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    GearButtonView(showSettings: .constant(false))
}
