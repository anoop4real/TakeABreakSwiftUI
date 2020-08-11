//
//  SoundPlayer.swift
//  Take-A-Break
//
//  Created by Anoop M on 2020-07-22.
//  Copyright © 2020 Anoop M. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {

    static var sound:AVAudioPlayer?
    static func playSound() {
        
        if let path = Bundle.main.path(forResource: "Horn", ofType: "mp3") {
            do {
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                print("Playing sound")
                sound?.play()
            } catch {
                print( "Could not find file")
            }
        }
    }
}
