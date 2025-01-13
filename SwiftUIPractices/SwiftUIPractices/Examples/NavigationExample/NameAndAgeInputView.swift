//
//  NameAndAgeInputView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//
import SwiftUI

struct NameAndAgeInputView: View {
    @State var name: String = ""
    @State var age: String = ""

    var navigationDisabled: Bool {
        name.isEmpty || age.isEmpty
    }

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

                } label: {
                    Text("Go")
                        .font(.title)
                        .padding()
                        .overlay {
                            Capsule()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                        }
                }.disabled(navigationDisabled)
            }
            .padding()
            .navigationTitle("Navigation Example")
        }
    }
}

#Preview {
    NameAndAgeInputView()
}
