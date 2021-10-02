//
//  main.swift
//  text_to_speech
//
//  Created by Кирилл on 18.09.2021.
//

import Foundation
import SwiftUI
import CoreData

struct main: View {
    let persistenceController = PersistenceController.shared
    @StateObject var tabview_router = Tabview_router()
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 0.141, green: 0.141, blue: 0.141))
                .frame(height: UIScreen.screenHeight )
                .edgesIgnoringSafeArea(.all)
                switch tabview_router.currentPage{
                case Page_main.text:
                    Text_View().environment(\.managedObjectContext, persistenceController.container.viewContext)
                case .history:
                    History_View().environment(\.managedObjectContext, persistenceController.container.viewContext)
                case .favourite:
                    Favourite_View().environment(\.managedObjectContext, persistenceController.container.viewContext)
                case .settings:
                    Settings_View()
                }
            VStack{
                HStack{
                    
                TabBarIcon(tabview_router: tabview_router, assignedPage: .text, width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/28, systemIconName: "Chat", tabName: "Home")
                TabBarIcon(tabview_router: tabview_router, assignedPage: .history, width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/28, systemIconName: "Time", tabName: "History")
                TabBarIcon(tabview_router: tabview_router, assignedPage: .favourite, width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/28, systemIconName: "Star", tabName: "Favourite")
                TabBarIcon(tabview_router: tabview_router, assignedPage: .settings, width: UIScreen.screenWidth/5, height: UIScreen.screenHeight/28, systemIconName: "Setting", tabName: "Settings")
                }
                .frame(width: UIScreen.screenWidth * 0.95, height: UIScreen.screenHeight/7, alignment: .center)
                .background(Color.black)
                .cornerRadius(20)
                .padding(.top, 40)
                Spacer()
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
         }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct main_Previews: PreviewProvider {
    static var previews: some View {
        main()
    }
}
