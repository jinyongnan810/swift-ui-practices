//
//  NavigationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

enum NavigationDemo: String, CaseIterable {
    case basic = "Basic Navigation With Link"
    case withValue = "Navigation With Value"
    case splitView = "Navigation Split View"
    case splitViewWithValue = "Navigation Split View With Value"
}

// https://developer.apple.com/jp/videos/play/wwdc2022/10054/
struct NavigationExample: View {
    @State var selectedDemo: NavigationDemo? = nil
    @State var showDemo: Bool = false
    var body: some View {
        // Cannot use nested NavigationStack,
        // for NavigationWithValueView won't work when NavigationStack is nested.
        // In this demo, I'm using sheet to seperate NavigationStack
        List {
            ForEach(NavigationDemo.allCases, id: \.self) { demo in
                Button(action: {
                    withAnimation {
                        if selectedDemo == nil {
                            selectedDemo = demo
                            showDemo.toggle()
                        }
                    }
                }) {
                    Text(demo.rawValue)
                }
            }

        }.sheet(isPresented: $showDemo) {
            if case .basic = selectedDemo {
                NameAndAgeInputView()
            } else if case .withValue = selectedDemo {
                NavigationWithValueView()
            } else if case .splitView = selectedDemo {
                NavigationSplitViewExample()
            } else if case .splitViewWithValue = selectedDemo {
                NavigationSplitViewWithValueExample()
            }
        }.onChange(of: showDemo) { _, newValue in
            if !newValue {
                selectedDemo = nil
            }
        }
    }
}

#Preview {
    NavigationExample()
}
