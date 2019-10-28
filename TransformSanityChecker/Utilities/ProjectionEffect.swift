//
//  ProjectionEffect.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI


extension CATransform3D: Animatable {
    
    
    
    public var animatableData: CATransform3D.AnimatableData {
        get {
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(
                        AnimatablePair(m11, m12),
                        AnimatablePair(m13, m14)),
                    AnimatablePair(
                        AnimatablePair(m21, m22),
                        AnimatablePair(m23, m24))),
                AnimatablePair(
                    AnimatablePair(
                        AnimatablePair(m31, m32),
                        AnimatablePair(m33, m34)),
                    AnimatablePair(
                        AnimatablePair(m41, m42),
                        AnimatablePair(m43, m44))))
        }
        set(newValue) {
            m11 = newValue.first.first.first.first
            m12 = newValue.first.first.first.second
            m13 = newValue.first.first.second.first
            m14 = newValue.first.first.second.second
            m21 = newValue.first.second.first.first
            m22 = newValue.first.second.first.second
            m23 = newValue.first.second.second.first
            m24 = newValue.first.second.second.second
            m31 = newValue.second.first.first.first
            m32 = newValue.second.first.first.second
            m33 = newValue.second.first.second.first
            m34 = newValue.second.first.second.second
            m41 = newValue.second.second.first.first
            m42 = newValue.second.second.first.second
            m43 = newValue.second.second.second.first
            m44 = newValue.second.second.second.second
            
        }
    }
    
    public typealias AnimatableData = AnimatablePair<
        AnimatablePair<
        AnimatablePair<
        AnimatablePair<CGFloat, CGFloat>,
        AnimatablePair<CGFloat, CGFloat>>,
        AnimatablePair<
        AnimatablePair<CGFloat, CGFloat>,
        AnimatablePair<CGFloat, CGFloat>>>,
        AnimatablePair<
        AnimatablePair<
        AnimatablePair<CGFloat, CGFloat>,
        AnimatablePair<CGFloat, CGFloat>>,
        AnimatablePair<
        AnimatablePair<CGFloat, CGFloat>,
        AnimatablePair<CGFloat, CGFloat>>>>
    
}



struct ProjectionEffect: GeometryEffect {
    var transform: CATransform3D
    
    
    var animatableData: CATransform3D.AnimatableData {
        get {
            transform.animatableData
        }
        set(newValue) {
            transform.animatableData = newValue
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(transform)
    }
}
