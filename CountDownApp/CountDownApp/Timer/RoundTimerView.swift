//
//  RoundTimerView.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import Foundation
import SwiftUI

struct RoundTimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 200, height: 200)
                .overlay(
                    Circle().stroke(Color.black.opacity(0.2), lineWidth: 25)
                )
            
            Circle()
                .fill(Color.clear)
                .frame(width: 200, height: 200)
                .overlay(
                    Circle().trim(from:0, to: CGFloat(viewModel.progress))
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 25,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                        .foregroundColor(
                            (viewModel.completed ? Color.orange : Color.red)
                        ).animation(
                            .easeInOut(duration: 0)
                        )
                )
            
            Text(viewModel.timeRemaining.format)
                .font(.title2.bold())
                .foregroundColor(Color.black)
                .contentTransition(.numericText())
        }
    }
}

struct RoundTimerView_Previews: PreviewProvider {
    static var previews: some View {
        RoundTimerView(viewModel: TimerViewModel(totalDuration: 60))
    }
}

