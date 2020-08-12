//
//  TakeABreakDataStore.swift
//  Take-A-Break
//
//  Created by Anoop M on 2020-06-28.
//  Copyright © 2020 Anoop M. All rights reserved.
//

import Foundation

class TakeABreakDataStore: ObservableObject {
    private static let _shared = TakeABreakDataStore()
    private let multiplier = 1
    private var currTimer: Timer?
    private var maxTimerCount: Int = 0
    private let timeIntervals = ["20", "40", "60"]
    @Published var tick: Int = 0
    @Published var picked: Int = 0 { didSet {
        pickedItem(index: picked)
    } }
    @Published var shouldShowAlert: Bool = false
    class func shared() -> TakeABreakDataStore {
        return _shared
    }
    
    private init() {
        initializeData()
    }
    
    private func initializeData() {
        maxTimerCount = 20 * multiplier
        tick = 0
    }
    
    private func pickedItem(index: Int) {
        let interval = timeIntervals[index]
        if let intervalVal = Int(interval) {
            maxTimerCount = intervalVal * multiplier
        }
    }
    
    func intervalAt(index: Int) -> String {
        return timeIntervals[index]
    }
    
    func intervalCount() -> Int {
        return timeIntervals.count
    }
    
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    func storeTextToUserDefaults(text: String) {
        let pref = UserDefaults.standard
        pref.set(text, forKey: "dispString1")
    }
    
    func getDisplayStringfromDefaults() -> String {
        let pref = UserDefaults.standard
        var savedString = ""
        if let dataStr = pref.object(forKey: "dispString1") as? String {
            savedString = dataStr
        }
        return savedString
    }
    
    func startTimer() {
        shouldShowAlert = false
        currTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        currTimer?.invalidate()
        tick = 0
    }
    
    func messageToDisplay() -> String {
        let newString = "\(getDisplayStringfromDefaults()) \nNo break taken since:\(getDateAsString())"
        return newString
    }
    
    @objc private func update() {
        tick += 1
        if tick >= maxTimerCount {
            tick = 0
            shouldShowAlert = true
            SoundPlayer.playSound()
        }
    }
}
