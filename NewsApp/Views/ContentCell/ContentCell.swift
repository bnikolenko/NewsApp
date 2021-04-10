//
//  ContentCell.swift
//  NewsApp
//
//  Created by Bodia on 24.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    override func prepareForReuse() {
        contentLabel.text = nil
    }
}

extension ContentCell: ArticleModelFillable {
    func fill(with model: ArticleModel) {
        contentLabel.text = model.content
    }
}
