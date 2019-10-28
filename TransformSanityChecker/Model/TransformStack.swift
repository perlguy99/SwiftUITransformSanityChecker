//
//  TransformStack.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI


// MARK: Transform3D

enum TransformTokens {
    case identity
    case rotation(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat, _ angle: CGFloat)
    case translation(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat)
    case scale(_ x: CGFloat, _ y: CGFloat, _ z: CGFloat)
    
    
    var short: String {
        switch self {
        case .identity:
            return "I"
        case .rotation(let x, let y, let z, let angle):
            return "R \(String(format: "%.2f", Double(x))) \(String(format: "%.2f", Double(y))) \(String(format: "%.2f", Double(z))) \(String(format: "%.2f", Double(angle)))"
        case .translation(let x, let y , let z):
           return "T \(String(format: "%.2f", Double(x))) \(String(format: "%.2f", Double(y))) \(String(format: "%.2f", Double(z)))"
        case .scale(let x, let y, let z):
           return "S \(String(format: "%.2f", Double(x))) \(String(format: "%.2f", Double(y))) \(String(format: "%.2f", Double(z)))"
        }
    }
    
    var verbose: String {
           switch self {
           case .identity:
               return "Identity"
           case .rotation(let x, let y, let z, let angle):
               return "Rotation x: \(String(format: "%.2f", Double(x))) y: \(String(format: "%.2f", Double(y))) z: \(String(format: "%.2f", Double(z))) angle: \(String(format: "%.2f", Double(angle)))"
           case .translation(let x, let y , let z):
              return "Translation x: \(String(format: "%.2f", Double(x))) y: \(String(format: "%.2f", Double(y))) z: \(String(format: "%.2f", Double(z)))"
           case .scale(let x, let y, let z):
              return "Scale x: \(String(format: "%.2f", Double(x))) y: \(String(format: "%.2f", Double(y))) z: \(String(format: "%.2f", Double(z)))"
           }
       }
    
    var matrix: TextMatrix4x4 {
        switch self {
        case .identity:
            return TextMatrix4x4(transform: CATransform3DIdentity)
        case .rotation(let x, let y, let z, let angle):
            return TextMatrix4x4(transform: CATransform3DMakeRotation(angle, x, y, z))
        case .translation(let x, let y , let z):
           return TextMatrix4x4(transform: CATransform3DMakeTranslation(x, y, z))
        case .scale(let x, let y, let z):
           return TextMatrix4x4(transform: CATransform3DMakeScale(x, y, z))
        }
    }
    
    
    
}

extension TransformTokens: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

class TransformStack: ObservableObject {
    @Published var transforms: [CATransform3D] = [CATransform3DIdentity]
    @Published var tokens: [TransformTokens] = [.identity]
    
    var combined: CATransform3D {
        if transforms.count > 1 {
            var combo = transforms[0]
            for (i, t) in transforms.enumerated() {
                if i > 0 {combo = CATransform3DConcat(combo, t)}
            }
            return combo
        }
        
        return CATransform3DIdentity
    }
    
    var reversed: CATransform3D {
        if transforms.count > 1 {
            var combo = transforms[0]
            for (i, t) in transforms.reversed().enumerated() {
                if i > 0 {combo = CATransform3DConcat(combo, t)}
            }
            return combo
        }
        
        return CATransform3DIdentity
    }
    
    
    func generatePoints(_ start: CGPoint) -> [CGPoint] {
        var points: [CGPoint] = [start]
        if transforms.count > 1 {
            var combo = transforms[0]
            for i in 0...transforms.count-1 {
                if i > 0 {
                    combo = CATransform3DConcat(combo, transforms[i])
                    print(start.applying(ProjectionTransform(combo)))
                    points.append(start.applying(ProjectionTransform(combo)))
                }
            }
        }
        return points
    }
    
    struct MyPoint: Identifiable {
        var id: String = UUID().uuidString
        
        var point: CGPoint
    }
    
    
    func convertToIdentifiable(start: CGPoint) -> [MyPoint] {
        self.generatePoints(start).map({ MyPoint(point: $0) })
    }
    
    func append(transform: CATransform3D) {
        transforms.append(transform)
    }
    
    func append(token: TransformTokens) {
        tokens.append(token)
    }
    
    func reset() {
        transforms = [CATransform3DIdentity]
        tokens = [.identity]
    }
}

