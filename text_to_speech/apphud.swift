//
//  apphud.swift
//  text_to_speech
//
//  Created by Кирилл on 28.09.2021.
//

import Foundation
import ApphudSDK
import StoreKit
import SwiftUI

extension SKProductSubscriptionPeriod {
    public var localizedDescription: String {
            let period:String = {
                switch self.unit {
                case .day: return "day"
                case .week: return "week"
                case .month: return "month"
                case .year: return "year"
                @unknown default:
                    return "unknown period"
                }
            }()
        
            let plural = numberOfUnits > 1 ? "s" : ""
            return "\(numberOfUnits) \(period)\(plural)"
        }
}

/*class apphud: View{
    private var product: ApphudProduct!
    private var title: String?
    private var subtitle: String?
    private var subunits: Int?
    var Price: String!
    var subperiod: String!
    var trialperiod: String!
    var a = onBoarding(viewRouter: <#StateObject<ViewRouter>#>)
   
    func subscribeButtonAction(){
        // 4 - Делаем покупку
        Apphud.purchase(product) { [self]result in
            if let subscription = result.subscription, subscription.isActive(){
                self.viewRouter.currentPage = .main
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive(){
                self.viewRouter.currentPage = .main
            } else {
               // handle error or check transaction status.
            }
        }
    }
    
    func configure() {
        configureProduct()
        subperiod =  product.skProduct?.subscriptionPeriod?.localizedDescription
        trialperiod = product.skProduct?.introductoryPrice?.subscriptionPeriod.localizedDescription
        let numberFormatter = NumberFormatter()
        let locale = product.skProduct?.priceLocale
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = locale
        Price = numberFormatter.string(from:  product.skProduct!.price)
    }


    func restore_product(){
        Apphud.restorePurchases{ subscriptions, purchases, error in
           if Apphud.hasActiveSubscription(){
             // has active subscription
           } else {
             // no active subscription found, check non-renewing purchases or error
           }
        }
    }
    
    func configureProduct() {
        // - 3. Конфигурируем apphud product
        Apphud.getPaywalls { [weak self] (paywalls, _) in // - 3.1 - Берем все пэйволы
            if let paywall = paywalls?.last { // - 3.2 - Берем нужный нам пэйвол(last - после - пэйвол, first - первый и т.д.)
                guard let product = paywall.products.first else { // - 3.3 - проверяем есть ли покупка
                   // self?.dismiss(animated: true, completion: nil)
                    return
                }
                self?.product = product
                let json = paywall.json // - 3.4 - Берем json который создавали в apphud

                self?.title = json?["title"] as? String
                self?.subtitle = json?["subtitle"] as? String

            } else {
              //  self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}*/
