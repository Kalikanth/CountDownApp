//
//  Extensions.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import Foundation
import SwiftUI

extension TimeInterval {
    var format: String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        let milliseconds = Int(self * 100) % 100
        
        return String(format: "%02dm:%02ds:%02d", minutes, seconds, milliseconds)
    }
}

extension View {
    func actionButtonStyle(isValid: Bool = true) -> some View {
        self
            .font(.title2)
            .padding()
            .background(Color.cyan.opacity(isValid ? 1.0 : 0.2))
            .foregroundColor(Color.black)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
