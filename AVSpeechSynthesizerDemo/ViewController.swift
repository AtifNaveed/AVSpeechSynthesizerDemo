//
//  ViewController.swift
//  AVSpeechSynthesizerDemo
//
//  Created by Atif on 26/08/2018.
//  Copyright © 2018 Danat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var sTextView: UITextView!
    @IBOutlet var sRateSlider: UISlider!
    @IBOutlet var sPitchSlider: UISlider!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var languageButton: UIButton!
    var sLanguage:String!
    var speechSynthesizer: AVSpeechSynthesizer!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthesizer = AVSpeechSynthesizer.init()
        speechSynthesizer.delegate = self
        
        sLanguage = "en-US"
        sTextView.text = "Hey, how are you doing today?"
    }
    
    
    @IBAction func speechAction(_ sender: Any) {
        speechText(toBeSpoken: self.sTextView.text)
    }
    
    @IBAction func speechRateAction(_ sender: Any) {
        print(sRateSlider.value)
    }
    
    @IBAction func speechPitchAction(_ sender: Any) {
        print(sPitchSlider.value)
    }
    
    @IBAction func languageAction(_ sender: Any) {
        //        for i in AVSpeechSynthesisVoice.speechVoices() {
        //            print(i.language)
        //        }
        let i = Int(arc4random_uniform(UInt32(AVSpeechSynthesisVoice.speechVoices().count)))
        sLanguage = AVSpeechSynthesisVoice.speechVoices()[i].language
        self.languageButton.setTitle("Language: \(sLanguage!)", for: .normal)
    }
    
    func speechText(toBeSpoken: String) {
        let sVoice = AVSpeechSynthesisVoice.init(language: sLanguage)
        let speechUtterance = AVSpeechUtterance.init(string: toBeSpoken)
        speechUtterance.rate = sRateSlider.value // [0 - 1] Default = 0.5
        speechUtterance.pitchMultiplier = sPitchSlider.value  //[0.5 - 2] Default = 1
        speechUtterance.voice = sVoice
        
        if speechSynthesizer.isSpeaking {
            playButton.setTitle("Play", for: .normal)
            speechSynthesizer.stopSpeaking(at: .word)
        }
        else {
            playButton.setTitle("Stop", for: .normal)
            speechSynthesizer.speak(speechUtterance)
        }
    }
}

extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        playButton.setTitle("Play", for: .normal)
    }
}




