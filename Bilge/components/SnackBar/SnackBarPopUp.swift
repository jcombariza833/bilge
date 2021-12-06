//
//  SnackBarPopUp.swift
//  CustomLoginExample
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 7/16/21.
//

import Foundation
import SwiftUI

struct SnackBarPopUp: ViewModifier {
    @Binding var isPresented: Bool
    var labelText: String
    var leadingIcon: String?
    var textColor: Color?
    var color: Color?
    var buttonText: String?
    var buttonColor: Color?
    var action: (() -> ())?
    
    var dismiss = Dissmiser()
    
    @State private var snackbarSize: CGSize = .zero
    @State private var contentSize: CGSize = .zero
    @State private var contentSafeSize: EdgeInsets = EdgeInsets()

    func body(content: Content) -> some View {
        dismiss.work?.cancel()
        dismiss.work = DispatchWorkItem(block: {
            withAnimation(.easeInOut(duration: 0.4)) {
                isPresented = false
            }
        })
        
        if let work = dismiss.work {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: work)
        }
        
        return ZStack {
            content
            
            if isPresented {
                snackbar
                    .background(
                        GeometryReader { geometry -> AnyView in
                            let frame = geometry.frame(in: .global)
                            
                            if frame.size != self.snackbarSize {
                                DispatchQueue.main.async {
                                    self.snackbarSize = frame.size
                                }
                            }
            
                            return AnyView(EmptyView())
                        }
                    )
                    .position(x: self.contentSize.width/2, y: self.contentSize.height - self.snackbarSize.height)
                    .onDisappear(perform: {
                        dismiss.work?.cancel()
                    })
            }
        }
        .background(
            GeometryReader { geometry -> AnyView in
                let frame = geometry.frame(in: .global)
                
                if frame.size != self.contentSize {
                    DispatchQueue.main.async {
                        self.contentSize = frame.size
                        self.contentSafeSize = geometry.safeAreaInsets
                    }
                }

                return AnyView(EmptyView())
            }
        )
    }
    
    private var snackbar: some View {
        SnackBar(labelText: labelText,
                 leadingIcon: leadingIcon,
                 textColor: textColor,
                 color: color,
                 buttonText: buttonText,
                 buttonColor: buttonColor,
                 action: {
                    if let action = action {
                        action()
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isPresented = false
                        }
                    }
                 })
            .opacity(isPresented ? 1.0 : 0.0)
            .scaleEffect(isPresented ? 1.0 : 0.0)
            
    }
}
