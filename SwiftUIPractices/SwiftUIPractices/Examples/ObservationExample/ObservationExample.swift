//
//  ObservationExample.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/16.
//

import SwiftUI
import Observation

struct ObservationExample: View {
    @State var randomNumber: Int = 0
    var body: some View {
        VStack {
            Text("Random Number: \(randomNumber)")

            Button("Generate Random Number") {
                    self.randomNumber = Int.random(in: 0...100)
            }

            SomeViewThatHasObservedProperties().padding()
        }

    }
}

// To support iOS version < 17
// Checkout ObservableObject, @Published, @ObservedObject/@StateObject
@Observable
class SomeViewModel {
    var data1: String = "Data1 Before"
    var data2: String = "Data2 Before"
}

struct SomeViewThatHasObservedProperties: View {
//    var viewModel: SomeViewModel = .init() // without @State, the state will be initialized when parent updates
    @State var viewModel: SomeViewModel = .init()
    var body: some View {
        VStack {
            Text(viewModel.data1)
            Text(viewModel.data2)
            Button("Change Data") {
                viewModel.data1 = "Data1 After"
                viewModel.data2 = "Data2 After"
            }
        }
    }
}

#Preview {
    ObservationExample()
}
