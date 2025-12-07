//
//  TextFieldPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/25.
//

import SwiftUI

struct TextFieldPractice: View {
    var body: some View {
        List {
            NavigationLink("Custom TextField with Email Validataion") {
                CustomTextFieldWithEmailValidation()
            }
            NavigationLink("Multiline TextField") {
                MultilineTextField()
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextFieldPractice()
    }
}
