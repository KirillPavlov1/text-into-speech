//
//  MotherView.swift
//  text_to_speech
//
//  Created by Кирилл on 18.09.2021.
//

import Foundation
import SwiftUI
import CoreData

struct MotherView: View{
    @StateObject var viewRouter: ViewRouter

    var body: some View{
        switch viewRouter.currentPage {
        case .onBoarding:
            onBoarding(viewRouter: viewRouter)
        case .main:
            main()
        }
    }
}

struct MotherView_Previews: PreviewProvider {

    static var previews: some View {
        MotherView(viewRouter: ViewRouter())
    }
}
