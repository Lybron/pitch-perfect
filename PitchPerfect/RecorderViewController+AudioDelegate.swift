//
//  RecorderViewController+AudioDelegate.swift
//  PitchPerfect
//
//  Created by Lybron Sobers on 3/3/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension RecordSoundsViewController: AVAudioRecorderDelegate {
  
  // MARK: AVAudioRecorder Delegate
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    
    if flag {
      performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    } else {
      
      let failureAlertController = UIAlertController(title: "Uh-oh!", message: "Something went wrong saving your recording. Please try again.", preferredStyle: .alert)
      failureAlertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
      self.present(failureAlertController, animated: true, completion: nil)

    }
    
  }
  
}
