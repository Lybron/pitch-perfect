//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Lybron Sobers on 3/2/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

  @IBOutlet weak var recordingLabel: UILabel!
  
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopRecordingButton: UIButton!
  
  var audioRecorder: AVAudioRecorder!
  
  enum RecordingState: Int { case notRecording = 0, recording }
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    configureUI()
  }
  
  @IBAction func recordAudio(_ sender: Any) {
    
    updateRecordingUIState(.recording)
    
    let directoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let recordingName = "recordingVoice.wav"
    let pathArray = [directoryPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator:"/"))
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func stopRecording(_ sender: Any) {
    updateRecordingUIState(.notRecording)
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  private func updateRecordingUIState(_ state: RecordingState) {
    if state == .recording {
      recordingLabel.text = "Recording in progress..."
    } else {
      recordingLabel.text = "Tap to Record"
    }
    
    let isRecording = Bool(state.rawValue as NSNumber)
    
    recordButton.isEnabled = !isRecording
    stopRecordingButton.isEnabled = isRecording
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destination as! PlaySoundsViewController
      playSoundsVC.recordedAudioURL =  sender as! URL
    }
  }
  
  private func configureUI() {
    recordButton.imageView?.contentMode = .scaleAspectFit
    stopRecordingButton.imageView?.contentMode = .scaleAspectFit
    
    stopRecordingButton.isEnabled = false
  }
  
}

