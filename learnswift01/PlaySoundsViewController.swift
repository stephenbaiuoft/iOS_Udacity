//
//  PlaySoundsViewController.swift
//  learnswift01
//
//  Created by stephen on 7/13/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudioURL: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slowButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        fastButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        highPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        lowPitchButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
    
        setupAudio()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch (ButtonType(rawValue: sender.tag)! )
        {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate:1.5)
        case .chipmunk:
            playSound(pitch: 1000.0)
        case .vader:
            playSound(pitch: -100.0)
        case .echo:
            playSound(echo:true)
        case .reverb:
            playSound(reverb:true)
        }
            
        configureUI(.playing)
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
        //print("stop audio button pressed")
    }
}
