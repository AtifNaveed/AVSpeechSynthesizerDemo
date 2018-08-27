//
//  ViewController.swift
//  AVSpeechSynthesizerDemo
//
//  Created by Atif on 26/08/2018.
//  Copyright © 2018 atif.gcucs@gmail.com. All rights reserved.
//
/*
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechSynthesizer = AVSpeechSynthesizer.init()
        speechSynthesizer.delegate = self
        
        sLanguage = "en-US"
        sTextView.text = "Hey, How are you doing today? How is weather in Dubai?"
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




