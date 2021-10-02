//
//  History.swift
//  text_to_speech
//
//  Created by Кирилл on 21.09.2021.
//

import Foundation
import SwiftUI
import CoreData

struct History_View: View{
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \History.text, ascending: true)],
        animation: .default)
    private var items: FetchedResults<History>
    @State var navigationViewIsActive: Bool = false
    @State var selectedModel : String? = nil
    @ObservedObject var userSettings = UserSettings()
    @State private var text_color = Color.white
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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
                                        .font(Font.custom("Montserrat", size: 16))
                                        .multilineTextAlignment(.leading)
                                        .frame(width: UIScreen.screenWidth * 0.25, height: UIScreen.screenHeight * 0.03, alignment: .leading)
                                    }
                                
                            }
                            .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.06, alignment: .leading)
                            .cornerRadius(15)
                            .padding(.bottom, 5)
                        }
                    }
                }
                .padding(.top, 100)
            }
        }
    }
}
}

struct  History_View_Previews: PreviewProvider {

    static var previews: some View {
        History_View()
    }
}
