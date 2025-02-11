//
//  HighScoreList.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct HighScoreList: View {
    @Environment(
        HighScoreViewModel.self
    ) var viewModel: HighScoreViewModel
    var body: some View {
        List {
            ForEach(
                Array(viewModel.highScores.enumerated()),
                id: \.element
                    .id
            ) { index, highScore in
                HighScoreItem(index: index, highScore: highScore)
            }
            .onDelete(perform: viewModel.deleteHighScore)
            .listRowBackground(Color.clear)
        }.listStyle(.plain)
    }
}

struct HighScoreItem: View {
    @Environment(
        HighScoreViewModel.self
    ) var viewModel: HighScoreViewModel
    let index: Int
    let highScore: HighScoreEntity
    @State private var editMode: Bool = false
    @State private var name: String = ""
    @FocusState private var isFocused: Bool
    init(
        index: Int,
        highScore: HighScoreEntity
    ) {
        self.index = index
        self.highScore = highScore
        name = highScore.name ?? ""
    }

    var body: some View {
        if editMode {
            HStack {
                TextField("Enter name", text: $name).foregroundStyle(.white)
                    .padding(.vertical)
                    .focused($isFocused, equals: true)
                Button(action: {
                    viewModel
                        .updateHighScoreUserName(entity: highScore, newName: name)
                    withAnimation {
                        editMode = false
                    }
                }) {
                    Text("Save").foregroundStyle(.white)
                }.disabled(name.isEmpty)
                    .padding()
                Button(action: {
                    withAnimation {
                        editMode = false
                    }
                }) {
                    Text("Cancel").foregroundStyle(.white)
                }.padding()
            }.padding(.horizontal)
                .onAppear {
                    isFocused = true
                }

        } else {
            HStack {
                HighScoreItemText(text: "\(index + 1)")
                Spacer()
                HighScoreItemText(text: highScore.name ?? "Anonymous")
                Spacer()
                HighScoreItemText(text: "\(highScore.score)")
            }
            .padding(.vertical, 8)
            .contextMenu {
                Button {
                    editMode = true
                    isFocused = true
                } label: {
                    Text("Edit")
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

struct HighScoreItemText: View {
    let text: String
    var body: some View {
        Text(text).font(.headline).fontWeight(.semibold)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    HighScoreList().environment(HighScoreViewModel())
}
