//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Bodia on 13.02.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct ArticleModel: Codable {
    struct Source {
        let id: String
        let name: String
    }
    
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let content: String
    let publishedAt: Date
}
