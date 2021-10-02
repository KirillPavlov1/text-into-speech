//
//  Settings.swift
//  text_to_speech
//
//  Created by Кирилл on 25.09.2021.
//

import Foundation
import SwiftUI

struct Settings_View: View{
    @ObservedObject var userSettings = UserSettings()
    var intProxy: Binding<Double>{
            Binding<Double>(get: {
                return Double(userSettings.font_size)
            }, set: {
                userSettings.font_size = Int($0)
            })
        }
    var intProxy2: Binding<Double>{
            Binding<Double>(get: {
                return Double(userSettings.line_spacing)
            }, set: {
                userSettings.line_spacing = Int($0)
            })
        }
    var intProxy3: Binding<Double>{
            Binding<Double>(get: {
                return Double(userSettings.rate)
            }, set: {
                userSettings.rate = Float($0)
            })
     }
    var body: some View{
       ZStack{
            Rectangle()
                .fill(Color(red: 0.141, green: 0.141, blue: 0.141))
                .frame(height: UIScreen.screenHeight )
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                        .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.15)
                        .cornerRadius(30)
                    VStack{
                        Text("Font Size")
                            
                            .font(Font.custom("Montserrat", size: 22))
                            .frame(width: UIScreen.screenWidth * 0.9, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading, 50)
                        HStack{
                           
                            ZStack{
                                Text("A")
                                    .font(.system(size: 17))
                                    .foregroundColor(.gray)
                                    .padding(.leading, 35)
                                    .frame(width: UIScreen.screenWidth,alignment: .leading)
                            Slider(value: intProxy, in: 5.0...50.0, step: 1.0)
                                .padding([.leading, .trailing], 65)
                                .accentColor(.orange)
                                Text("A")
                                    .font(.system(size: 27))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 35)
                                    .frame(width: UIScreen.screenWidth,alignment: .trailing)
                            }
                        }
                    }
                }
                .padding(.bottom, 40)
                ZStack{
                    Rectangle()
                        .fill(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                        .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.15)
                        .cornerRadius(30)
                    VStack{
                        Text("Rate")
                            .font(Font.custom("Montserrat", size: 22))
                            .frame(width: UIScreen.screenWidth * 0.9, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading, 50)
                        Slider(value: intProxy3, in: 0.0...1.0, step: 0.05)
                            .padding([.leading, .trailing], 65)
                            .accentColor(.orange)
                      
                    }
                }
                .padding(.bottom, 40)
                ZStack{
                    Rectangle()
                        .fill(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                        .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight * 0.15)
                        .cornerRadius(30)
                    VStack{
                        Text("Delay")
                            .font(Font.custom("Montserrat", size: 22))
                            .frame(width: UIScreen.screenWidth * 0.9, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading, 50)
                            .padding(.top, 5)
                        Text("Add a delay between sentences")
                            .font(Font.custom("Montserrat", size: 16))
                            .frame(width: UIScreen.screenWidth * 0.9, alignment: .leading)
                            .foregroundColor(.gray)
                            .padding(.leading, 50)
                        Slider(value: intProxy2, in: 0.0...30.0, step: 1.0)
                            .padding([.leading, .trailing], 65)
                            .accentColor(.orange)
                    }
                }
                Spacer()
                HStack{
                    Link("Privacy Policy", destination: URL(string: "https://docs.google.com/document/d/12l5TPza_n1qXTYTcbijyUKXEtNH_eYbG-es-MNcqQZg/edit?usp=sharing")!)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                    Text("          |          ")
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                    Link("Terms Of Use", destination: URL(string: "https://docs.google.com/document/d/12l5TPza_n1qXTYTcbijyUKXEtNH_eYbG-es-MNcqQZg/edit?usp=sharing")!)
                        .font(.system(size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                .padding(.bottom, 20)
               
            }
            .padding(.top, 110)
            
        }
    }
}


struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings_View()
    }
}

