//
//  TimerViewModel.swift
//  CountDownApp
//
//  Created by kiran kumar Gajula on 13/01/24.
//

import Combine
import Foundation
import UIKit

class TimerViewModel: ObservableObject {
    
    @Published var timeRemaining: TimeInterval
    @Published var isTimerRunning = false
    @Published var totalDuration: TimeInterval
    @Published var progress: CGFloat = 0
    @Published var completed: Bool = false
    private var notificationHandler: NotificationHandler
    private var currentIdentifier: String = ""
    
    private var activeCheckDate: Date!

    private var timerCancellable: AnyCancellable?
    
    init(totalDuration: TimeInterval,notificationHandler: NotificationHandler = NotificationHandler()) {
        self.totalDuration = totalDuration
        self.timeRemaining = totalDuration
        self.notificationHandler = notificationHandler
    }

    func startTimer() {
        if isTimerRunning {
            pauseTimer()
        }else {
            isTimerRunning = true
            completed = false
            currentIdentifier = UUID().uuidString
            timerCancellable = Timer.publish(every: 0.01, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    guard let self = self else { return }
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 0.01
                        self.progress = 1.0 - (self.timeRemaining / self.totalDuration)
                    } else {
                        self.completed = true
                        self.stopTimer()
                    }
                }
        }
    }

    func pauseTimer() {
        isTimerRunning = false
        timerCancellable?.cancel()
    }

    func stopTimer() {
        isTimerRunning = false
        timeRemaining = totalDuration
        progress = 0
        completed = false
        timerCancellable?.cancel()
    }
    
    func scheduleNotification() {
        guard isTimerRunning else { return }
        self.activeCheckDate = Date().addingTimeInterval(timeRemaining)
        self.notificationHandler.sendLocalNotification(uuid:currentIdentifier, timeInterval: self.timeRemaining, title: "Timer update!", body: "Countdown copleted")
    }
    
    func removeNotification() {
        notificationHandler.removeScheduledNotification(withIdentifier: currentIdentifier)
    }
    
    func updateTimer() {
        guard activeCheckDate != nil else { return }
        let timeinterval = activeCheckDate.timeIntervalSince(Date())
        if timeinterval < 0 {
            stopTimer()
        }else {
            timeRemaining = activeCheckDate.timeIntervalSince(Date())
        }
    }
}
