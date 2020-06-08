//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation // 소리 재생 API

class ViewController: UIViewController {
    var player: AVAudioPlayer! // 플레이어

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimer = ["Soft": 300, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var secondPassed = 0
  
    var timer = Timer()
    @IBAction func hardnessPressed(_ sender: UIButton) {
        
        timer.invalidate() // 이미 진행 중인 실행의 시간을 stop
        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!
        
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondPassed < totalTime {
            secondPassed += 1
            // ProgressBar가 진행됨
            progressBar.setProgress(Float(secondPassed) / Float(totalTime), animated: true)
        

        } else {
            timer.invalidate() // counter가 0이 되면 시간을 멈춤
            titleLabel.text = "DONE!" // titleLabel을 DONE!로 변경
            playSound(soundName: "alarm_sound") // 알람음 발생
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
