//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Lybron Sobers on 3/2/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  @IBOutlet weak var slowButton: UIButton!
  @IBOutlet weak var fastButton: UIButton!
  @IBOutlet weak var highButton: UIButton!
  @IBOutlet weak var lowButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  
  var recordedAudioURL: URL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: Timer!
  
  enum ButtonType: Int { case slow = 0, fast, high, low, echo, reverb }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupAudio()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureUI(.notPlaying)
    setPlaybackButtonsContentMode()
  }
  
  
  @IBAction func playSoundForButton(_ sender: UIButton) {
    switch (ButtonType(rawValue: sender.tag)!) {
    
    case .slow: playSound(rate: 0.5)
    case .fast: playSound(rate: 1.5)
    case .high: playSound(pitch: 1000)
    case .low:  playSound(pitch: -1000)
    case .echo: playSound(echo: true)
    case .reverb: playSound(reverb: true)
      
    configureUI(.playing)
      
    }
    
  }
  
  @IBAction func stopButtonPressed(_ sender: Any) {
    stopAudio()
  }
  
  func setPlaybackButtonsContentMode() {
    slowButton.imageView?.contentMode = .scaleAspectFit
    fastButton.imageView?.contentMode = .scaleAspectFit
    highButton.imageView?.contentMode = .scaleAspectFit
    lowButton.imageView?.contentMode = .scaleAspectFit
    echoButton.imageView?.contentMode = .scaleAspectFit
    reverbButton.imageView?.contentMode = .scaleAspectFit
  }

}
