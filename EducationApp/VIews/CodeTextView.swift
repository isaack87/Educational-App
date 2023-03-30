//
//  CodeTextView.swift
//  EducationApp
//
//  Created by Isaac Kim on 3/29/23.
//

import SwiftUI


struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }
    
    func updateUIView(_ uiTextView: UITextView, context: Context) {
        
        //set attributed text
        uiTextView.attributedText = model.codeText
        
        //scroll back to the top
        uiTextView.setContentOffset(.zero, animated: true)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
