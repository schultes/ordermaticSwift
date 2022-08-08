//
//  MultilineTextView.swift
//  teamA
//
//  Created by FMA1 on 28.07.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.textContainer.lineFragmentPadding = 3
        textView.textContainerInset = .zero
        textView.font = UIFont.systemFont(ofSize: 14)
        
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<TextView>) {
        uiView.text = text
        uiView.delegate = context.coordinator
    }
    
    func frame(numLines: CGFloat) -> some View {
        let height = UIFont.systemFont(ofSize: 17).lineHeight * numLines
        return self.frame(height: height)
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        init(_ parent: TextView) {
            self.parent = parent
        }
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
