//
//  Theme.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/31.
//
import SwiftUI

#if os(iOS)
    enum Theme {
        static let listStyle = DefaultListStyle()
        static let hotkeyItemLayout: AnyLayout = .init(
            VStackLayout(alignment: .leading)
        )
        static let minWidth: CGFloat? = nil
        static let minHeight: CGFloat? = nil
    }
#else
    enum Theme {
        static let listStyle = SidebarListStyle()
        static let hotkeyItemLayout: AnyLayout = .init(
            HStackLayout()
        )
        static let minWidth: CGFloat? = 500
        static let minHeight: CGFloat? = 400
    }
#endif
