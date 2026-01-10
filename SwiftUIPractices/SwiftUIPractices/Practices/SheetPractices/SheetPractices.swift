//
//  SheetPractices.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/10.
//

import SwiftUI

struct SheetPractices: View {
    var body: some View {
        List {
            NavigationLink("Sheet Zoom Transition") {
                SheetZoomTransition()
            }
            NavigationLink("Sheet with height") {
                SheetWithHeightPractice()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SheetPractices()
    }
}
