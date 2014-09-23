//
//  YelpClient.swift
//  yelp
//
//  Created by Li Yu on 9/22/14.
//  Copyright (c) 2014 Li Yu. All rights reserved.
//

import Foundation
private let _SingletonSharedInstance = YelpClient(
    consumerKey:    "kAKOhmx_bDX7PZCtKJFXTA",
    consumerSecret: "JEh3MGfpYkrlDA0FWq8VI0CEovo",
    accessToken:    "bfreyd0TrGGXu2uAaZX0SLNhXUDhOPqo",
    accessSecret:   "EUOKQdAl7-6KrWEMxsNRhunpo2s"
)

class YelpClient: BDBOAuth1RequestOperationManager {
    class var sharedInstance : YelpClient {
        return _SingletonSharedInstance
    }

    init(consumerKey: String, consumerSecret: String, accessToken: String, accessSecret: String) {
        let baseURL = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
        let token: BDBOAuthToken = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        requestSerializer.saveAccessToken(token)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func search(term: String, category: String, sort: Int, radius: Int, deal: Bool,
        callback: (response: AnyObject!, error: NSError!) -> Void) -> AFHTTPRequestOperation {
        var parameters = [
            "term": term,
            "location": "San Jose",
            "category_filter": category,
            "radius_filter": radius * 1600,
            "deals_filter": deal,
            "sort": sort
        ]
        
        return
            self.GET("search", parameters: parameters,
                success: {
                    (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        callback(response: response, error: nil)
                },
                failure: {
                    (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println("\(error)")
                        callback(response: nil, error: error)
                }
            )
    }

}


