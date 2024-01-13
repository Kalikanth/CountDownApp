//
//  CountDownTimer.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import SwiftUI
import UIKit

struct CountDownTimer: View {
    
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            Spacer()
            RoundTimerView(viewModel: viewModel)
            Spacer()
            
            HStack(spacing: 24) {
                Button {
                    viewModel.startTimer()
                } label: {
                    Text(viewModel.isTimerRunning ? "Pause" : "Start")
                    Image(systemName: "stopwatch")
                }
                .actionButtonStyle(isValid: !viewModel.isTimerRunning)
                
                Button {
                    viewModel.stopTimer()
                } label: {
                    Text("Reset")
                }
                .actionButtonStyle(isValid: viewModel.isTimerRunning)
                .disabled(!viewModel.isTimerRunning)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: UIApplication.didEnterBackgroundNotification,
                object: nil,
                queue: .main
            ) { _ in
                viewModel.scheduleNotification()
            }

            NotificationCenter.default.addObserver(
                forName: UIApplication.didBecomeActiveNotification,
                object: nil,
                queue: .main
            ) { _ in
                viewModel.removeNotification()
                viewModel.updateTimer()
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(self)
        }
    }
}

struct CountDownTimer_Previews: PreviewProvider {
    static var previews: some View {
        CountDownTimer(viewModel: TimerViewModel(totalDuration: 60))
    }
}
