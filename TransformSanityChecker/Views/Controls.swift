//
//  Controls.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI


struct TransformControls: View {
    @ObservedObject var stack: TransformStack
    var angleRange: ClosedRange<CGFloat> = -.pi...CGFloat.pi
    var rotationVectorRange: ClosedRange<CGFloat> = -1...1
    var translateRange: ClosedRange<CGFloat> = -500...500
    var scaleRange: ClosedRange<CGFloat> = -2...2
    var rotationFormat: String = "%.2f"
    var translationFormat: String = "%.0f"
    var scaleFormat: String = "%.2f"
    @State var angle: CGFloat = 0
    @State var rX: CGFloat = 0
    @State var rY: CGFloat = 0
    @State var rZ: CGFloat = 0
    @State var translateX: CGFloat = 0
    @State var translateY: CGFloat = 0
    @State var translateZ: CGFloat = 0
    @State var scaleX: CGFloat = 0
    @State var scaleY: CGFloat = 0
    @State var scaleZ: CGFloat = 0
    
    var rotationSliders: some View {
        HStack {
            VStack {
                Text("x: \(String(format: rotationFormat, Double(rX)))")
                Slider(value: $rX, in: rotationVectorRange)
            }
            VStack {
                Text("y: \(String(format: rotationFormat, Double(rY)))")
                Slider(value: $rY, in: rotationVectorRange)
            }
            VStack {
                Text("z: \(String(format: rotationFormat, Double(rZ)))")
                Slider(value: $rZ, in: rotationVectorRange)
            }
            VStack {
                Text("angle: \(String(format: rotationFormat, Double(angle)))")
                Slider(value: $angle, in: angleRange).padding([.leading, .trailing])
            }
        }
    }
    
    
    var rotationButton: some View {
        Button(action:
            {
                withAnimation(.default) {
                    self.addTransform(t: CATransform3DMakeRotation(self.angle, self.rX, self.rY, self.rZ))
                    self.addToken(t: .rotation(self.rX, self.rY, self.rZ, self.angle))
                }
        }) {
            Text("Add Rotation")
        }
    }
    
    var translationSliders: some View {
        HStack {
            VStack {
                Text("x: \(String(format: translationFormat, Double(translateX)))")
                Slider(value: $translateX, in: translateRange)
            }
            VStack {
                Text("y: \(String(format: translationFormat, Double(translateY)))")
                Slider(value: $translateY, in: translateRange)
            }
            VStack {
                Text("z: \(String(format: translationFormat, Double(translateZ)))")
                Slider(value: $translateZ, in: translateRange)
            }
        }
    }
    
    var translationButton: some View {
        Button(action: {
            self.addTransform(t: CATransform3DMakeTranslation(self.translateX, self.translateY, self.translateZ))
            self.addToken(t: .translation(self.translateX, self.translateY, self.translateZ))
        }) {
            Text("Add Translation ")
        }
    }
    
    var scaleSliders: some View {
        HStack {
            VStack {
                Text("x: \(String(format: scaleFormat, Double(scaleX)))")
                Slider(value: $scaleX, in: scaleRange)
            }
            VStack {
                Text("y: \(String(format: scaleFormat, Double(scaleY)))")
                Slider(value: $scaleY, in: scaleRange)
            }
            VStack {
                Text("z: \(String(format: scaleFormat, Double(scaleZ)))")
                Slider(value: $scaleZ, in: scaleRange)
            }
        }
    }
    
    var scaleButton: some View {
        Button(action: {
            self.addTransform(t: CATransform3DMakeScale(self.scaleX, self.scaleY, self.scaleZ))
            self.addToken(t: .scale(self.scaleX, self.scaleY, self.scaleZ))
        }) {
            Text("Add Scale")
        }
    }
    
    
    
    var body: some View {
        VStack {
            Button(action: { self.stack.reset() }, label: { Text("Reset") })
                .padding(.top)
            Divider()
            rotationSliders
            rotationButton
            Divider()
            translationSliders
            translationButton
            Divider()
            scaleSliders
            scaleButton
                .padding([.bottom])
        }
    }
    
    func addTransform(t: CATransform3D) {
        stack.append(transform: t)
    }
    
    func addToken(t: TransformTokens) {
        stack.append(token: t)
    }
}
