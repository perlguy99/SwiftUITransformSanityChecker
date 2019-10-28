//
//  TransformViewer.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI


struct TransformViewer: View {
    @ObservedObject var stack: TransformStack = TransformStack()
    
    var transformedView: some View {
        ZStack {
            GeometryReader { (proxy: GeometryProxy) in
                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
                    .frame(width: proxy.frame(in: .global).width*0.2, height: proxy.frame(in: .global).width*0.2, alignment: .center)
            }.modifier(ProjectionEffect(transform: stack.combined))
            .animation(.easeIn)
            
                
                
            TrackingPath(stack: stack).stroke(Color.white, lineWidth: 2).animation(.easeIn)
            PointsOverlay(stack: stack)
            textTracking
                .modifier(ProjectionEffect(transform: stack.combined))
        }
    }
    
    var textTracking: some View {
        GeometryReader { (proxy: GeometryProxy) in
            VStack {
                Text("Container Frame")
                Text("Global: x: \(String(format: "%.0f", Double(proxy.frame(in: .global).origin.x))) y: \(String(format: "%.0f", Double(proxy.frame(in: .global).origin.y))) w: \(String(format: "%.0f", Double(proxy.frame(in: .global).width))) h: \(String(format: "%.0f", Double(proxy.frame(in: .global).height)))")
                Text("local: x: \(String(format: "%.0f", Double(proxy.frame(in: .local).origin.x))) y: \(String(format: "%.0f", Double(proxy.frame(in: .local).origin.y))) w: \(String(format: "%.0f", Double(proxy.frame(in: .local).width))) h: \(String(format: "%.0f", Double(proxy.frame(in: .local).height)))")
            }
        }
    }
    
    
    var body: some View {
        HStack {
            Spacer()
            transformedView
            Spacer()
            Divider()
            VStack {
                StackView(tokens: stack.tokens)
                TextMatrix4x4(transform: stack.combined, title: "Combined Transform").frame(height: 125)
                Divider()
                TransformControls(stack: stack)
            }.frame(minWidth: 200, idealWidth: 400, maxWidth: 400, alignment: .center)
        }.frame(minWidth: 500, idealWidth: 1000, maxWidth: .infinity,
                minHeight: 500, idealHeight: 1000, maxHeight: .infinity,
                alignment: .center)
    }
}


struct TransformViewer_Previews: PreviewProvider {
    static var previews: some View {
        TransformViewer()
    }
}
