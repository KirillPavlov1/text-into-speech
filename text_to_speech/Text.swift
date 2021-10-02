//
//  ContentView.swift
//  text_to_speech
//
//  Created by Кирилл on 15.09.2021.
//

import SwiftUI
import AVFoundation

struct SuperTextField: View {
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    @ObservedObject var userSettings = UserSettings()
    @State private var text_color = Color.white
    init(text: Binding<String>){
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack{
                Text("Your Text")
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                    .font(Font.custom("Montserrat", size: 21))
                Text("Tap here to type!")
                .font(Font.custom("Montserrat", size: 17))
                .foregroundColor(.white)
                .opacity(0.25)
                .padding(.leading, 30)
                    
                }
            }
            
            TextEditor(text: $text)
                .foregroundColor(text_color)
                .font(Font.custom("Montserrat", size: CGFloat(userSettings.font_size)))
                .lineSpacing(CGFloat(userSettings.line_spacing))
                .frame(width: UIScreen.screenWidth * 0.75)
        }
    }
}

public class Play: ObservableObject {
    @Published var play1 = false
}

struct Text_View: View{
    @ObservedObject var userSettings = UserSettings()
    @State var text: String = ""
    @ObservedObject var helper = Play()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \History.text, ascending: true)],
        animation: .default)
    private var items: FetchedResults<History>
  
    var speech : Any!
    init()
    {
        speech = speech_synthesizer(play1: $helper.play1)
    }
    func button()
    {
        addItem()
        helper.play1 = !helper.play1
        if helper.play1
        {
            if (speech as! speech_synthesizer).synthesizer.isPaused
            {
                (speech as! speech_synthesizer).synthesizer.continueSpeaking()
            }
            else
            {
                if let language = NSLinguisticTagger.dominantLanguage(for: text) {
                    let speech2 = AVSpeechUtterance(string: text)
                    speech2.rate = Float(userSettings.rate)
                    speech2.voice = AVSpeechSynthesisVoice(language: language) //use the detected language
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
    
    private func addItem() {
        if (text == "")
        {
            return
        }
        withAnimation {
            let newItem = History(context: viewContext)
            newItem.text = self.text

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                ZStack{
                    Rectangle()
                        .fill(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                        .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenHeight * 0.17)
                        .cornerRadius(20)
                    SuperTextField(text: $text)
                        .frame(height: UIScreen.screenHeight * 0.13)
                        .background(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                        .font(Font.system(size: 18))
                        .cornerRadius(20)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            Button(action: {self.button()})
            {
                !helper.play1 ?
                    HStack{
                        Image(systemName: "play.fill")
                            .padding(.trailing, 6)
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(Color.white)
                            .font(Font.custom("Montserrat", size: 25))
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
                //.frame(height: UIScreen.screenHeight * 0.55)
                
                
         
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .edgesIgnoringSafeArea(.all)
        
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text_View()
    }
}
