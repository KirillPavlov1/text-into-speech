//
//  Favourite.swift
//  text_to_speech
//
//  Created by Кирилл on 22.09.2021.
//

import Foundation
import SwiftUI

struct Favourite_View: View{
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.text, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Favourite>
    @ObservedObject var userSettings = UserSettings()
    @State var navigationViewIsActive: Bool = false
    @State var selectedModel : String? = nil
    @State var text : String = ""
    @State var hid: Bool = false
    @State private var text_color = Color.white
    func button(){
        hid.toggle()
    }
    var body: some View{
    NavigationView{
    ZStack{
    Rectangle()
        .fill(Color(red: 0.141, green: 0.141, blue: 0.141))
        ZStack{
            Rectangle()
                .fill(Color(red: 0.141, green: 0.141, blue: 0.141))
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack{
                        if selectedModel != nil {
                            NavigationLink(destination: Text_View2(text: self.selectedModel!), isActive: $navigationViewIsActive){ EmptyView() }
                            }
                        }.hidden()
                VStack{
                    ForEach(items) { item in
                        Button(action: {self.selectedModel = item.text
                                self.navigationViewIsActive = true})
                        {
                            ZStack{
                                Rectangle()
                                    .fill(Color.init(#colorLiteral(red: 0.2102533281, green: 0.2129422426, blue: 0.2128478587, alpha: 1)))
                                Text("\(item.text!)")
                                    .foregroundColor(text_color)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.custom("Montserrat", size: 16))
                                    .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.03, alignment: .leading)
                                }
                            
                        }
                        .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.06, alignment: .leading)
                        .cornerRadius(15)
                        .padding(.bottom, 5)
                        }
                    }
            }
            .padding([.top], 100)
            .padding([.bottom], 100)
            VStack{
                Spacer()
                Button(action: {self.button()})
                {
                    Text("Add +")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Montserrat", size: 23))
                        
                }
                .frame(width: UIScreen.screenWidth * 0.30, height: UIScreen.screenHeight / 17)
                .background(LinearGradient(gradient: Gradient(colors: [ Color(red: 0.937, green: 0.498, blue: 0.188), Color(red: 0.925, green: 0.337, blue: 0.161)]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .init(x: 0.5, y: 1)))
                .cornerRadius(50)
                .padding(.bottom, 30)
            }
            if (hid)
            {
                Rectangle()
                    .fill(Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.6))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        hid = false
                    }
                new_favourite(text: $text, hid: $hid)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight * 0.4)
                    .background(Color.init(#colorLiteral(red: 0.372744292, green: 0.3787374496, blue: 0.3826265037, alpha: 1)))
                    .font(Font.system(size: 18))
                    .cornerRadius(10)
            }
        }
    }
    }
    }
}
