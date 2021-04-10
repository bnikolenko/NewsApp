//
//  EmptyCell.swift
//  NewsApp
//
//  Created by Bodia on 20.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {
    @IBOutlet weak var emptyCellLabel: UILabel!
    
    override func prepareForReuse() {
        emptyCellLabel.text = nil
    }
    
    func fill(with model: ArticleModel) {
        emptyCellLabel.text = "No articles to display"
    }
}
