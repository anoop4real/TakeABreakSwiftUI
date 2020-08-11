//
//  ButtonStyles.swift
//  Take-A-Break
//
//  Created by Anoop M on 2020-08-11.
//  Copyright © 2020 Anoop M. All rights reserved.
//

import Foundation
import SwiftUI

struct CapsuleStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.green

    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .foregroundColor(foreground)
            .padding(.leading, 5)
            .padding(.trailing, 5)
            .padding(.top, 2)
            .padding(.bottom, 2)
            .lineLimit(1)
            .background(Capsule()
                .fill(background.opacity(configuration.isPressed ? 0.7 : 1)))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct RoundBorderStyle: ButtonStyle {
    var foreground = Color.black
    var background = Color.white

    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .frame(minWidth: 50, maxWidth: 50)
            .foregroundColor(foreground)
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .padding(.top, 2)
            .padding(.bottom, 2)
            .lineLimit(1)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
