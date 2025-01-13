//
//  NameAndAgeDisplayView.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

struct NameAndAgeDisplayView: View {
    let name: String
    let age: String
    var body: some View {
        Text("name is \(name), age is \(age)")
    }
}

#Preview {
    NameAndAgeDisplayView(name: "Yuunan kin", age: "30")
}
