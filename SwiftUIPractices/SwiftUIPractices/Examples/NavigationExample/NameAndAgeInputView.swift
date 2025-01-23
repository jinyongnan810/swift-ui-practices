//
//  NameAndAgeInputView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//
import SwiftUI

struct NameAndAgeInputView: View {
    @Namespace private var namespace

    @State var name: String = ""
    @State var age: String = ""

    var navigationDisabled: Bool {
        name.isEmpty || age.isEmpty
    }

//    init() {
//        // this will effect entire app
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .foregroundColor: UIColor.orange,
//        ]
//    }

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Input Name")
                    TextField("Name", text: $name)
                    Text("Input Age")
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                }
                Spacer()
                NavigationLink {
                    NameAndAgeDisplayView(name: name, age: age)
                        .navigationTransition(
                            .zoom(sourceID: "myId", in: namespace)
                        )

                } label: {
                    Text("Go")
                        .font(.title)
                        .padding()
                        .overlay {
                            Capsule()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                        }
                }.disabled(navigationDisabled)
                    .matchedTransitionSource(id: "myId", in: namespace)
            }
            .padding()
            .navigationTitle("Navigation Example")
//            .onDisappear() {
//                UINavigationBar.appearance().largeTitleTextAttributes = [
//                    .foregroundColor: Color.black,
//                ]
//            }
        }
    }
}

#Preview {
    NameAndAgeInputView()
}
