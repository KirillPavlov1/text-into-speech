//
//  onboarding.swift
//  text_to_speech
//
//  Created by Кирилл on 28.09.2021.
//

import Foundation
import SwiftUI
import ApphudSDK
import StoreKit
import UserNotifications

struct image_switch: View{
    
    @Binding var currentTab: Int
    
    init(currentTab: Binding<Int>){
        self._currentTab = currentTab
    }
    var body: some View{
        switch currentTab{
        case 0:
            Image("onboarding1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        case 1:
            Image("onboarding2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        case 2:
            Image("onboarding3")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        case 3:
            Image("onboarding4")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        default:
            Image("onboarding1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct circles: View{
    
    private let circleSize: CGFloat = 9
    private let circleSpacing: CGFloat = 7
    private let primaryColor = Color.white
    private let secondaryColor = Color.white.opacity(0.6)
    private let smallScale: CGFloat = 0.6
    @Binding var currentTab: Int
    
    init(currentTab: Binding<Int>){
        self._currentTab = currentTab
    }
    var body: some View{
        HStack(spacing: circleSpacing) {
            ForEach(0..<4) { index in // 1
                if (currentTab == index)
                {
                    Rectangle()
                    .fill(primaryColor) // 2
                    .frame(width: circleSize * 3, height: circleSize)
                    .transition(AnyTransition.opacity.combined(with: .scale)) // 3
                    .cornerRadius(40)
                    .id(index) // 4
                
                }
                else
                {
                    Circle()
                    .fill(currentTab == index ? primaryColor : secondaryColor) // 2
                    .frame(width: currentTab == index ? circleSize : circleSize, height: circleSize)
                    .transition(AnyTransition.opacity.combined(with: .scale)) // 3
                    .id(index) // 4
                }
                }
            .padding(.top, 20)
            }
    }
}

struct links_restore: View{
    @StateObject var viewRouter: ViewRouter
    
    var body: some View{
        HStack{
                Link("Privacy Policy", destination: URL(string: "https://docs.google.com/document/d/12l5TPza_n1qXTYTcbijyUKXEtNH_eYbG-es-MNcqQZg/edit?usp=sharing")!)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                Text("     |   ")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                Button(action: {viewRouter.restore_product()})
                {
                    Text("Restore")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                }
                Text("   |     ")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
                Link("Terms Of Use", destination: URL(string: "https://docs.google.com/document/d/1pGFlAy6IxT5-AwwDrI-8bMMY26gW4bRQDJlUQTh7C84/edit?usp=sharing")!)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
        }
        .padding(.bottom, 20)
    }
}

struct onBoarding: View {
    @State private var currentTab = 0
    @State private var text_button = "Next →"
    @StateObject var viewRouter: ViewRouter
    @State private var last = false
   
    func `continue`()
    {
        if (currentTab < 3)
        {
            viewRouter.configure()
            currentTab+=1
            if (currentTab == 2)
            {
                SKStoreReviewController.requestReview()
            }
            if (currentTab == 3)
            {
                text_button = "Continue & Subscribe"
                last.toggle()
            }
        }
        else
        {
            
            if (Apphud.hasActiveSubscription())
            {
                viewRouter.currentPage = .main
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            else
            {
                viewRouter.subscribeButtonAction()
            }
        }
    }
    var body: some View {
        ZStack{
            image_switch(currentTab: $currentTab)
            VStack{
                Spacer()
                Spacer()
                circles(currentTab: $currentTab)
                Button(action: {self.continue()})
                {
                    Text(text_button)
                        .frame(width: UIScreen.screenWidth * 0.85, height: UIScreen.screenHeight / 17)
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.screenWidth * 0.6)
                .frame(height: UIScreen.screenHeight / 17)
                .background(LinearGradient(gradient: Gradient(colors: [ Color(red: 0.937, green: 0.498, blue: 0.188), Color(red: 0.925, green: 0.337, blue: 0.161)]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .init(x: 0.5, y: 1)))
                .cornerRadius(30)
                .padding(.bottom, 40)
                .padding(.top, 20)
                if (viewRouter.trialperiod != nil && last)
                {
                    Text("Trial period for \(String(viewRouter.trialperiod)) then \(String(viewRouter.Price))")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                else if (last)
                {
                    Text("Billed every \(String(viewRouter.subperiod)) at \(String(viewRouter.Price))")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                links_restore(viewRouter: viewRouter)
                }
        .edgesIgnoringSafeArea(.all)
    }
    }
}

/*struct onBoarding_Previews: PreviewProvider {
    static var previews: some View {
        onBoarding(viewRouter: S)
    }
}*/
