//
//  Client.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/26/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class Client {
    
    static let shopDomain = "dear-loa.myshopify.com"
    static let apiKey = "a651707c74b40cb1488b6ef9bb17ced4" // or a651707c74b40cb1488b6ef9bb17ced4
    static let merchantID = "merchant.com.dear.loa"
    
    static let shared = Client()
    
    private let client: Graph.Client = Graph.Client(shopDomain: Client.shopDomain, apiKey: Client.apiKey)
    
    // ------------------------
    // MARK: - Init -
    //
    private init() {
        self.client.cachePolicy = .cacheFirst(expireIn: 3600)
    }
    
    // ------------------------
    // MARK: - Init -
    //
    @discardableResult
    func fetchShopName(completion: @escaping (String?) -> Void) -> Task {
        
//        let query = ClientQuery 
    }
    
    
    
    
    
    
    
    
    
    
    
}
