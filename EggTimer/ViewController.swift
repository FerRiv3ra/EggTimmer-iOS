//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    
    var timer = Timer()
    var counter = 0
    var secondPassed = 0
    
    let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondPassed = 0
        
        let hardness = sender.currentTitle!
        mainLabel.text = hardness
        
        counter = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        secondPassed += 1
        progressBar.progress = Float(secondPassed) / Float(counter)
        
        if secondPassed == counter {
            mainLabel.text = "Done!"
            progressBar.progress = 1.0
            timer.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.mainLabel.text = "How do you like your eggs?"
            }
            
            do {
                player = try AVAudioPlayer(contentsOf: soundURL!)
                player?.play()
            } catch {
                print(error)
            }
        }
      }
    
}
