//
//  RecordSoundsViewController.swift
//  learnswift01
//
//  Created by stephen on 5/5/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit
import AVFoundation
/*

 1. because we set RecordSoundsViewController to conform to AVAudioRecorderDelegate protocol
 2. so this way, we have to implement the protocol specified function, audioRecorderDidFinishRecording
 
 3. now audioRecorder.delegate = self
 it means that audioRecorder instance will perform audioRecorderDidFinishRecording (as defined by us) to do the job
 */

class RecordSoundsViewController: UIViewController {
  
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    var audioRecorder: AVAudioRecorder!
    var alert: UIAlertController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled  = false;
        print("view appeared")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func recordAudio(_ sender: UIButton) {
        setUIState(state: true, msg: "Recording in Progress")
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        // AVAudioRecorderDelegate protocol is implemented in RecordSoundsViewController
        // so setting audioRecorder.delegate = self (RecordSoundsViewController) allows audioRecorder to notify this class
        audioRecorder.delegate = self
        
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    @IBAction func stopRecordingAudio(_ sender: UIButton) {
        setUIState(state: false, msg: "Tap to Record")
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // toggles the stopRecordingButton state
    func setUIState( state:Bool, msg:String){
        stopRecordingButton.isEnabled = state
        recordButton.isEnabled = !state
        recordLabel.text = msg
    
    }

    
    // this function prepares RecordSoundsViewController to segue to other view controllers based on input to performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

// extension areas!
extension RecordSoundsViewController:AVAudioRecorderDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully: Bool) {
        if(successfully){
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            alert = UIAlertController.init(title: "Audio Alert", message: "Recording Was Not Successful", preferredStyle: UIAlertControllerStyle.alert)
            present(alert, animated: true, completion: {
                print("Audio Alert Done here")
            })
            
        }
    }
}


