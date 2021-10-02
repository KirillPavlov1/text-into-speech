//
//  utils.swift
//  text_to_speech
//
//  Created by Кирилл on 18.09.2021.
//

import Foundation
import SwiftUI
import Combine

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UITabBarController{

    func getHeight()->CGFloat{
        return self.tabBar.frame.size.height
    }

    func getWidth()->CGFloat{
         return self.tabBar.frame.size.width
    }
}

struct LabelWithImageIcon: View {
    /// The title which will be passed to the title attribute of the Label View.
    let title: String
    /// The name of the image to pass into the Label View.
    let image: String
    
    var body: some View {
        VStack{
            Image(self.image)
                .renderingMode(.template)
                .foregroundColor(Color.yellow)
            Text(self.title)
        }
    }
}

struct new_favourite: View {
    @Binding var text: String
    @Binding var hid: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Favourite.text, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Favourite>
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    private func addItem() {
        withAnimation {
            let newItem = Favourite(context: viewContext)
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
    init(text: Binding<String>, hid: Binding<Bool>){
        self._text = text
        self._hid = hid
        UITextView.appearance().backgroundColor = .clear
        
    }
    var body: some View {
        ZStack(alignment: .leading) {
            VStack{
                ZStack{
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(10)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 10)
                    
                TextEditor(text: $text)
                    .foregroundColor(Color.orange)
                    .font(Font.custom("Montserrat", size: 20))
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 15)
                }
                Button(action: {hid.toggle(); addItem()})
                {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Montserrat", size: 28))
                    
                }
                    .frame(width: UIScreen.screenWidth * 0.30, height: UIScreen.screenHeight / 17)
                    .background(LinearGradient(gradient: Gradient(colors: [ Color(red: 0.937, green: 0.498, blue: 0.188), Color(red: 0.925, green: 0.337, blue: 0.161)]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .init(x: 0.5, y: 1)))
                    .cornerRadius(50)
                    .padding(.bottom, 18)
            }
        }
        
    }
}

struct TabBarIcon: View {
    @StateObject var tabview_router: Tabview_router
    let assignedPage: Page_main
    let width, height: CGFloat
    let systemIconName, tabName: String
  
    var body: some View {
         VStack {
             Image(tabview_router.currentPage == assignedPage ? systemIconName + "_fill" : systemIconName)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: width, height: height
                
                 )
                .padding([.top], UIScreen.screenHeight / 24)
             Text(tabName)
                .font(Font.custom("Montserrat", size: 14))
                .foregroundColor(tabview_router.currentPage == assignedPage ? Color.white : .gray)
             Spacer()
         }
         .onTapGesture{
                         tabview_router.currentPage = assignedPage
         }
     }
 }

/*class Text_color: ObservableObject{
    @State var text_color : Color = .white
}*/

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
