//
//  MatrixView.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI

struct TextMatrix4x4: View {
    var transform: CATransform3D
    var title: String = ""
    var format: String = "%.2f"
    
    var body: some View {
        VStack {
            Text(title)
            HStack {
                Divider()
                VStack {
                    Text("\(String(format: format, Double(transform.m11)))")
                    Text("\(String(format: format, Double(transform.m21)))")
                    Text("\(String(format: format, Double(transform.m31)))")
                    Text("\(String(format: format, Double(transform.m41)))")
                }
                VStack {
                    Text("\(String(format: format, Double(transform.m12)))")
                    Text("\(String(format: format, Double(transform.m22)))")
                    Text("\(String(format: format, Double(transform.m32)))")
                    Text("\(String(format: format, Double(transform.m42)))")
                }
                VStack {
                    Text("\(String(format: format, Double(transform.m13)))")
                    Text("\(String(format: format, Double(transform.m23)))")
                    Text("\(String(format: format, Double(transform.m33)))")
                    Text("\(String(format: format, Double(transform.m43)))")
                }
                VStack {
                    Text("\(String(format: format, Double(transform.m14)))")
                    Text("\(String(format: format, Double(transform.m24)))")
                    Text("\(String(format: format, Double(transform.m34)))")
                    Text("\(String(format: format, Double(transform.m44)))")
                }
                Divider()
            }
        }
    }
}
