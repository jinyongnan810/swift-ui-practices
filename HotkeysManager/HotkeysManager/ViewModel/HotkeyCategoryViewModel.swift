//
//  HotkeyCategoryViewModel.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//

import Foundation
import Observation

@Observable
class HotkeyCategoryViewModel {
    let categories: [HotkeyCategoryModel]
    init() {
        let productCategory: HotkeyCategoryModel = .init(
            name: "Product",
            hotkeys: [
                .init(modifiers: [.command], character: "B", text: "Build"),
                .init(modifiers: [.command], character: "R", text: "Run"),
                .init(modifiers: [.command], character: ".", text: "Stop"),
                .init(
                    modifiers: [.command, .shift],
                    character: "K",
                    text: "Clean Build Folder"
                ),
            ]
        )
        let schemeCategory: HotkeyCategoryModel = .init(
            name: "Scheme",
            hotkeys: [
                .init(modifiers: [.control], character: "0", text: "Choose Scheme"),
                .init(
                    modifiers: [.command],
                    character: "<",
                    text: "Edit Scheme"
                ),
            ]
        )
        let hideOrShowPanelsCategory: HotkeyCategoryModel = .init(name: "Hide or Show Panels", hotkeys: [
            .init(
                modifiers: [.command],
                character: "0",
                text: "Show/Hide Navigator (Left panel)"
            ),
            .init(
                modifiers: [.option, .shift],
                character: "0",
                text: "Show/Hide Utilities (Right panel)"
            ),
            .init(
                modifiers: [.shift],
                character: "Y",
                text: "Show/Hide the Debug area"
            ),
            .init(
                modifiers: [
                    .command,
                    .option,
                ],
                character: "⏎",
                text: "Show/Hide Canvas"
            ),
        ])
        let navigationCategory: HotkeyCategoryModel = .init(
            name: "Navigation",
            hotkeys: [
                .init(
                    modifiers: [.command],
                    character: "1",
                    text: "Project"
                ),
                .init(
                    modifiers: [.command],
                    character: "2",
                    text: "Source control"
                ),
                .init(
                    modifiers: [.command],
                    character: "3",
                    text: "Bookmarks"
                ),
                .init(
                    modifiers: [.command],
                    character: "4",
                    text: "Find"
                ),
                .init(
                    modifiers: [.command],
                    character: "5",
                    text: "Issues"
                ),
                .init(
                    modifiers: [.command],
                    character: "6",
                    text: "Tests"
                ),
                .init(
                    modifiers: [.command],
                    character: "7",
                    text: "Debug"
                ),
                .init(
                    modifiers: [.command],
                    character: "8",
                    text: "Breakpoints"
                ),
                .init(
                    modifiers: [.command],
                    character: "9",
                    text: "Reports"
                ),
            ]
        )
        let inspectorCategory: HotkeyCategoryModel = .init(name: "Inspector", hotkeys: [
            .init(modifiers: [.option, .command], character: "1", text: "File"),
            .init(modifiers: [.option, .command], character: "2", text: "History"),
            .init(modifiers: [.option, .command], character: "3", text: "Quick Help"),
            .init(modifiers: [.option, .command], character: "4", text: "Show Inspector"),
        ])
        let structureCategory: HotkeyCategoryModel = .init(name: "Structure", hotkeys: [
            .init(modifiers: [.command], character: "/", text: "Toggle comment/uncomment"),
            .init(modifiers: [.control], character: "I", text: "Re-indent selected code"),
            .init(modifiers: [.control], character: "M", text: "Format multiple lines"),
            .init(modifiers: [.command, .shift], character: "[", text: "Shift Left"),
            .init(modifiers: [.command, .shift], character: "]", text: "Shift Right"),
        ])
        let editingCategory: HotkeyCategoryModel = .init(name: "Editing", hotkeys: [
            .init(modifiers: [.command], character: "C", text: "Copy"),
            .init(modifiers: [.command], character: "V", text: "Paste"),
            .init(modifiers: [.command, .shift, .option], character: "V", text: "Paste and Preserve Formatting"), .init(modifiers: [.command], character: "D", text: "Duplicate"),
        ])
        let miscCategory: HotkeyCategoryModel = .init(name: "Miscellaneous", hotkeys: [
            .init(modifiers: [.command, .shift], character: "A", text: "Quick actions"),
            .init(modifiers: [.shift, .control], character: "🖱️", text: "Create a new cursor on every click"),
            .init(modifiers: [.shift, .control, .command], character: "M", text: "Minimap"),
            .init(modifiers: [.globe], character: "E", text: "Emojis"),
        ])
        let debuggingCategory: HotkeyCategoryModel = .init(name: "Debugging", hotkeys: [
            .init(modifiers: [.command], character: "\\", text: "Comment out"),
            .init(modifiers: [.control, .option, .command], character: "F", text: "Fix all in scope"),
        ])
        let fileMenuCommandsCategory: HotkeyCategoryModel = .init(name: "File menu commands", hotkeys: [
            .init(modifiers: [.command], character: "N", text: "New File"),
            .init(modifiers: [.command, .option], character: "N", text: "New Group"),
        ])
        let sourceControlCategory: HotkeyCategoryModel = .init(name: "Source Control", hotkeys: [
            .init(modifiers: [.command], character: "9", text: "Open the Source Control Navigator"),
            .init(modifiers: [.command, .option], character: "C", text: "Commit changes"),
        ])
        let categories: [HotkeyCategoryModel] = [
            productCategory,
            schemeCategory,
            hideOrShowPanelsCategory,
            navigationCategory,
            inspectorCategory,
            structureCategory,
            editingCategory,
            miscCategory,
            debuggingCategory,
            fileMenuCommandsCategory,
            sourceControlCategory,
        ]

        self.categories = categories
    }

    func filteredWith(searchTerm: String) -> [HotkeyCategoryModel] {
        guard !searchTerm.isEmpty else {
            return categories
        }

        return categories.map { category in
            let hotkeys = category.hotkeys.filter {
                $0.text.lowercased().contains(searchTerm.lowercased()) ||
                    $0.description.lowercased().contains(searchTerm.lowercased())
            }
            return HotkeyCategoryModel(name: category.name, hotkeys: hotkeys)
        }
    }
}
