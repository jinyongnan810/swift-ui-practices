//
//  DynamicIslandExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/11.
//

import SwiftUI

struct DynamicIslandExample: View {
    var body: some View {
        List {
            NavigationLink("Toast") {
                DynamicIslandToast()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DynamicIslandExample()
    }
}
