//
//  DescriptionCell.swift
//  NewsApp
//
//  Created by Bodia on 23.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        descriptionLabel.text = nil
    }
}

extension DescriptionCell: ArticleModelFillable {
    func fill(with model: ArticleModel) {
        descriptionLabel.text = model.description
    }
}
