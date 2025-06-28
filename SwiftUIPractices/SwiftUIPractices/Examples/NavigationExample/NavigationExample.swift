//
//  NavigationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/06/28.
//

import SwiftUI

enum NavigationDemo {
    case basic, withValue, split
}

struct NavigationExample: View {
    @State var selectedDemo: NavigationDemo? = nil
    @State var showDemo: Bool = false
    var body: some View {
        // Cannot use nested NavigationStack,
        // for NavigationWithValueView won't work when NavigationStack is nested.
        // In this demo, I'm using sheet to seperate NavigationStack
        List {
            Button(action: {
                withAnimation {
                    if selectedDemo == nil {
                        selectedDemo = .basic
                        showDemo.toggle()
                    }
                }
            }) {
                Text("Basic Navigation With Link")
            }
            Button(action: {
                withAnimation {
                    if selectedDemo == nil {
                        selectedDemo = .withValue
                        showDemo.toggle()
                    }
                }
            }) {
                Text("Navigation with Value")
            }
            Button(action: {
                withAnimation {
                    if selectedDemo == nil {
                        selectedDemo = .split
                        showDemo.toggle()
                    }
                }
            }) {
                Text("Navigation Split View")
            }
        }.sheet(isPresented: $showDemo) {
            if case .basic = selectedDemo {
                NameAndAgeInputView()
            } else if case .withValue = selectedDemo {
                NavigationWithValueView()
            } else if case .split = selectedDemo {
                NavigationSplitViewExample()
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
