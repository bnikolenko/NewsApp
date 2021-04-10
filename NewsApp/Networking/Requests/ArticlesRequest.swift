//
//  ArticlesRequest.swift
//  NewsApp
//
//  Created by Bodia on 14.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import Foundation

//"http://newsapi.org/v2/everything?
//q=apple
//&from=2021-03-13
//&to=2021-03-13
//&sortBy=popularity
//&apiKey=f01212ed32d0495ab3066077bd751012"

var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}

struct ArticlesRequest: RequestType {
    let query: String?
    let from: Date
    let to: Date
    let sortBy: String
    
    var endpoint: String {
        return "/v2/everything"
    }
    var method: Method = .get
    var body: BodyType? = nil
    var queryItems: QueryItemsType? {
        let fromString = dateFormatter.string(from: from) ?? ""
        let toString = dateFormatter.string(from: to) ?? ""
        
        return ["q": query, "from": fromString, "to": toString, "sortBy": sortBy, "apiKey": apiKey]
    }
    
    
}
