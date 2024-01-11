//
//  TTView_Previews.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 11/01/2024.
//

import SwiftUI

struct ViewPreview: UIViewRepresentable {
    let viewBuilder: () -> UIView
    
    init(viewBuilder: @escaping () -> UIView) {
        self.viewBuilder = viewBuilder
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewBuilder()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
