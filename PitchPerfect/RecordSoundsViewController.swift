//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Eyvind on 3/3/22.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{
    
    @IBOutlet weak var labelRecord: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        print("viewDidLoad()")
        super.viewDidLoad()
        configuringUI(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear()")
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func onRecord(_ sender: Any) {
        print("onRecord()")
        
        configuringUI(true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func onStopRecord(_ sender: Any) {
        print("onStopRecord()")
        configuringUI(false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorderDidFinishRecording()")
        if flag {
            print("Save recording successfully")
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        }else{
            print("Save recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func configuringUI(_ isRecording: Bool){
        print("configuringUI() isRecording=\(isRecording)")
        if isRecording{
            labelRecord.text = "Recording in progress"
            recordButton.setCustomEnable(false)
            stopRecordingButton.setCustomEnable(true)
        } else {
            labelRecord.text = "Tap to record"
            recordButton.setCustomEnable(true)
            stopRecordingButton.setCustomEnable(false)
        }
    }
    
}


