//
//  BlurView.swift
//  AlertToastPreview
//
//  Created by אילי זוברמן on 14/02/2021.
//

import Foundation
import SwiftUI

#if os(macOS)

@available(macOS 11, *)
public struct BlurView: NSViewRepresentable {
    public typealias NSViewType = NSVisualEffectView
    
    let material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode
    
    public func makeNSView(context: Context) -> NSVisualEffectView {
        let effectView = NSVisualEffectView()
        effectView.material = material
        effectView.blendingMode = blendingMode
        effectView.state = NSVisualEffectView.State.active
        return effectView
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        nsView.material = material
        nsView.blendingMode = blendingMode
    }
}

#else

@available(iOS 13, *)
public struct BlurView: UIViewRepresentable {
    public typealias UIViewType = UIVisualEffectView
    
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: self.style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: self.style)
    }
}

#endif
