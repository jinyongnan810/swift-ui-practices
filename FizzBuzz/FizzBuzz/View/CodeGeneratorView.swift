//
//  CodeGeneratorView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

struct CodeGeneratorView: View {
    @Environment(AlgViewModel.self) var viewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.models) {
                    model in
                    NavigationLink(model.name) {
                        ZStack {
                            Color.blue.opacity(0.2).ignoresSafeArea()
                            ScrollView {
                                VStack {
                                    Text(model.fizzBuzzCode)
                                        .font(.headline)
                                        .padding()
                                        .contextMenu {
                                            Button {
                                                UIPasteboard.general.string = model.fizzBuzzCode
                                            } label: {
                                                Text("Copy To Clipboard")
                                                Image(systemName: "doc.on.doc")
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CodeGeneratorView().environment(AlgViewModel())
}
