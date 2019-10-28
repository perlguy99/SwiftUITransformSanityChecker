//
//  TrackingPath.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI

struct PointView: View {
    var point: CGPoint
    var size: CGFloat
    @State var isVisible: Bool = false
    
    var body: some View {
        ZStack {
            Circle().fill().foregroundColor(.red).frame(width: size, height: size, alignment: .center)
            Text("(\(String(format: "%.0f", Double(point.x))) , \(String(format: "%.0f", Double(point.y))))")
                .opacity(self.isVisible ? 1 : 0)
            .onHover { _ in self.isVisible.toggle() }
        }.position(CGPoint(x: point.x, y: point.y))
    }
    
    
}

struct PointsOverlay: View  {
    @ObservedObject var stack: TransformStack
    
    
    var body: some View {
        GeometryReader { (proxy: GeometryProxy) in
            ZStack {
                ForEach(self.stack.convertToIdentifiable(start: CGPoint(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY))) { pt in
                    ZStack {
                        PointView(point: pt.point, size: proxy.frame(in: .global).width*0.03)
                    }
                }
            }
        }
    }
}


struct TrackingPath: Shape {
    @ObservedObject var stack: TransformStack
    
    
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        
        var path = Path()
        let start = CGPoint(x: w/2, y: h/2)

        for (i, pt) in stack.generatePoints(start).enumerated() {
            i == 0 ? path.move(to: pt) : path.addLine(to: pt)
        }
        
       return path
        
    }
}
