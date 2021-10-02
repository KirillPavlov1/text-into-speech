//
//  audio.swift
//  text_to_speech
//
//  Created by Кирилл on 17.09.2021.
//

import Foundation
import SwiftUI
import AVFoundation

class speech_synthesizer: NSObject, AVSpeechSynthesizerDelegate{
    @Binding var play: Bool
    public var synthesizer = AVSpeechSynthesizer()
    init(play1 : Binding<Bool>)
    {
        _play = play1
        super.init()
        self.synthesizer.delegate = self
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        play = false
    }
}
