//
//  StackView.swift
//  TransformSanityChecker
//
//  Created by Kieran Brown on 10/28/19.
//  Copyright © 2019 Kieran Brown. All rights reserved.
//

import Foundation
import SwiftUI

struct StackView: View {
    var tokens: [TransformTokens]
    @State var showMatrix: Bool = false
    
    var body: some View {
        VStack {
            Toggle(isOn: $showMatrix, label: {Text(!showMatrix ? "Show Matrix?": "Show Short?")})
            List(tokens) { t in
                !self.showMatrix ? AnyView(Text( t.short )): AnyView(t.matrix)
            }
        }
    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        StackView(tokens: [.identity, .translation(100, 200, 300), .rotation(1, 1, 0, 25)])
    }
}
