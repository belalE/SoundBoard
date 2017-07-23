//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by mac pro on 7/22/17.
//  Copyright © 2017 Elsiesy Industries. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audiorecorder : AVAudioRecorder? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setuprecorder()
    }
    
    func setuprecorder() {
        do {
            // Create Audio Session
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file
            
            let basepath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basepath, "Audio.m4a"]
            
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("##############")
            print(audioURL)
            print("##############")

            
            //Create Settings for Audio Recorder
            
            var settings : [String : Any ] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
            // Create Audio recorder Object
            audiorecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audiorecorder?.prepareToRecord()
        } catch let error as NSError {
        print(error)
        }
    }
    
    @IBAction func RecordTapped(_ sender: Any) {
        
        if audiorecorder!.isRecording {
            //Stop The recording
            audiorecorder?.stop()
            
            //Change Button title to record
            RecordButton.setTitle("Record", for: .normal)
        } else {
            //Start the recording
            audiorecorder?.record()
            //Change button title to stop
            RecordButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    
    @IBAction func PlayTapped(_ sender: Any) {
    }
    
    @IBAction func AddTapped(_ sender: Any) {
    }
    
    
}
