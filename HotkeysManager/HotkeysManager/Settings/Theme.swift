//
//  Theme.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/31.
//
import SwiftUI

#if os(iOS)
struct Theme {
    static let listStyle = DefaultListStyle()
    static let hotkeyItemLayout: AnyLayout = AnyLayout(
        VStackLayout(alignment: .leading)
    )
    static let minWidth: CGFloat? = nil
    static let minHeight: CGFloat? = nil
}
#else
struct Theme {
    static let listStyle = SidebarListStyle()
    static let hotkeyItemLayout: AnyLayout = AnyLayout(
        HStackLayout()
    )
    static let minWidth: CGFloat? = 500
    static let minHeight: CGFloat? = 400
}
#endif
