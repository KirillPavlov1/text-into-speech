//
//  Text2.swift
//  text_to_speech
//
//  Created by Кирилл on 21.09.2021.
//

import Foundation
import SwiftUI
import AVFoundation


struct Text_View2: View{
    @ObservedObject var userSettings = UserSettings()
    @State var text: String
    @ObservedObject var helper = Play()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var speech : Any!
    init(text: String)
    {
        self._text = State(initialValue: text)
        speech = speech_synthesizer(play1: $helper.play1)
    }
    func button()
    {
        helper.play1 = !helper.play1
        if helper.play1
        {
            if (speech as! speech_synthesizer).synthesizer.isPaused
            {
                (speech as! speech_synthesizer).synthesizer.continueSpeaking()
            }
            else
            {
                //let speech2 = AVSpeechUtterance(string: text)
                if let language = NSLinguisticTagger.dominantLanguage(for: text) {
                    let speech2 = AVSpeechUtterance(string: text)
                    speech2.voice = AVSpeechSynthesisVoice(language: language)
                    speech2.rate = Float(userSettings.rate)
                        //use the detected language
                    (speech as! speech_synthesizer).synthesizer.speak(speech2)
                }
                else {
                }
            }
        }
        else
        {
            if (speech as! speech_synthesizer).synthesizer.isSpeaking {
                (speech as! speech_synthesizer).synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
            }
        }
    }
    
    var body: some View {
     
        ZStack(){
            Rectangle()
                .fill(Color(red: 0.141, green: 0.141, blue: 0.141))
                .frame(height: UIScreen.screenHeight )
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            VStack{
                Spacer()
                HStack{
                    Button(action: {self.presentationMode.wrappedValue.dismiss()})
                {
                    
                    Text("<  Back to History")
                        .foregroundColor(.orange)
                        .font(Font.custom("Montserrat", size: 16))
                }
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    Spacer()
                }
                .padding(.top, 70)
            SuperTextField(text: $text)
            .frame(height: UIScreen.screenHeight * 0.13)
            .background(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
            .font(Font.system(size: 18))
            .cornerRadius(20)
            Button(action: {self.button()})
            {
                !helper.play1 ?
                    HStack{
                        Image(systemName: "play.fill")
                            .padding(.trailing, 6)
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(Color.white)
                            .font(Font.custom("Montserrat", size: 27))
                    }
                    :
                    HStack{
                        Image(systemName: "stop.fill")
                            .padding(.trailing, 6)
                            .foregroundColor(.white)
                        Text("Stop")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                    }
                
                
            }
            .frame(width: UIScreen.screenWidth * 0.30, height: UIScreen.screenHeight / 17)
                .background(LinearGradient(gradient: Gradient(colors: [ Color(red: 0.937, green: 0.498, blue: 0.188), Color(red: 0.925, green: 0.337, blue: 0.161)]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .init(x: 0.5, y: 1)))
                .cornerRadius(50)
                .padding(.top, 30)
                Spacer()
                    .frame(height: UIScreen.screenHeight * 0.55)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.top, 100)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}

struct Text2_Previews: PreviewProvider {
    static var previews: some View {
        Text_View2(text: "")
    }
}
