//
//  File.swift
//
//
//  Created by אילי זוברמן on 14/02/2021.
//

import SwiftUI

#if os(macOS)
@available(macOS 11, *)
struct ActivityIndicator: NSViewRepresentable {
    
	let color: Color
	
	init(color: Color) {
	    self.color = color
	}
	
    func makeNSView(context: NSViewRepresentableContext<ActivityIndicator>) -> NSProgressIndicator {
        let nsView = NSProgressIndicator()
        
        nsView.isIndeterminate = true
        nsView.style = .spinning
        nsView.startAnimation(context)
        
        return nsView
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: NSViewRepresentableContext<ActivityIndicator>) {
    }
}
#else
@available(iOS 13, *)
struct ActivityIndicator: UIViewRepresentable {

    let color: Color
    
    init(color: Color) {
        self.color = color
    }
	
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        
        let progressView = UIActivityIndicatorView(style: .large)
		if #available(iOS 14.0, *) {
		    if let cgColor = color.cgColor?.copy() {
		        progressView.color = UIColor(cgColor: cgColor)
		    }
		} else {
		    let uiHostingController = UIHostingController(rootView: color)
		    if let cgColor = uiHostingController.view.backgroundColor?.cgColor.copy() {
		        progressView.color = UIColor(cgColor: cgColor)
		    }
		}
        progressView.startAnimating()
        
        return progressView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    }
}
#endif
