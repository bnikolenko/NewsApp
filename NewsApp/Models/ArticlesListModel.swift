//
//  ArticlesListModel.swift
//  NewsApp
//
//  Created by Bodia on 13.02.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct ArticlesListModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}
