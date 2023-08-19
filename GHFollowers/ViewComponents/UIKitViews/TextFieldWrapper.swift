//
//  TextFieldWrapper.swift
//  GHFollowers
//
//  Created by Alpay Calalli on 19.08.23.
//

import SwiftUI

struct GFTextFieldWrapper: UIViewRepresentable {
    typealias UIViewType = GFTextField

    @Binding var text: String

    func makeUIView(context: Context) -> GFTextField {
        let textField = GFTextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: GFTextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}
