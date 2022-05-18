//
//  File.swift
//  
//
//  Created by Luke Martin-Resnick on 5/17/22.
//

import SwiftUI

struct PlaceholderTextView: UIViewRepresentable {
    
    @Binding var text: String
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.textAlignment = .left
        textView.text = text.isEmpty ? placeholder : text
        textView.font = UIFont(name: "BrandonGrotesque-Regular", size: 14)
        textView.textColor = UIColor.black.withAlphaComponent(0.75)
        textView.backgroundColor = UIColor.white
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 1.0
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent: PlaceholderTextView
        
        init(_ parent: PlaceholderTextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = UIColor.black.withAlphaComponent(0.75)
            }
        }
    }
}
