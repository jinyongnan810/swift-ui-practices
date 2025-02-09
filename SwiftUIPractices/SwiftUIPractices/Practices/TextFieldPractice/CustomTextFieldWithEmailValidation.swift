//
//  CustomTextFieldWithEmailValidation.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2025/01/25.
//

import SwiftUI

struct CustomTextFieldWithEmailValidation: View {
    @State private var email: String = ""
    var emailIsEmpty: Bool { email.isEmpty }
    var title: String { emailIsEmpty ? "Enter Email" : "Current Email" }
    var titleColor: Color { emailIsEmpty ? .red : .blue }
    var emailValid: Bool {
        !email.isEmpty && email.isValidEmail()
    }

    @FocusState private var isFocused: Bool

    @State private var showPlaceholder: Bool = true
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundStyle(titleColor)
                .fontWeight(.semibold)
            if !emailIsEmpty {
                Text(email)
                    .foregroundColor(.green)
            }
            Spacer()
            VStack {
                ZStack {
                    TextField("", text: $email.animation())
                        .focused($isFocused)
                        .font(.title2)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(false)
                        .textInputAutocapitalization(.none)
                        .padding()
                        .onTapGesture {
                            showPlaceholder = false
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.gray, lineWidth: 1)
                        )

                        .overlay(alignment: .leading) {
                            Label("Email", systemImage: "envelope")
                                .foregroundStyle(.gray)
                                .padding()
                                .allowsHitTesting(false)
                                .opacity(showPlaceholder && emailIsEmpty ? 1 : 0)
                        }
                }
                Text("Invalid Email Format")
                    .foregroundColor(.red)
                    .opacity(!emailValid && !emailIsEmpty ? 1 : 0)
            }
        }.onTapGesture {
            isFocused = false
        }
        .padding()
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

#Preview {
    CustomTextFieldWithEmailValidation()
}
