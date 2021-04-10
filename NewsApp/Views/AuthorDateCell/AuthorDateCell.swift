//
//  AuthorDateCell.swift
//  NewsApp
//
//  Created by Bodia on 26.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class AuthorDateCell: UITableViewCell {
    @IBOutlet weak var byAuthorLabel: UILabel!
    @IBOutlet weak var onDateLabel: UILabel!
    
    override func prepareForReuse() {
        byAuthorLabel.text = nil
        onDateLabel.text = nil
    }
}

extension AuthorDateCell: ArticleModelFillable {
    func fill(with model: ArticleModel) {
        byAuthorLabel.text = ["by", model.author].joined(separator: " ")
        onDateLabel.text = ["posted on", model.publishedAt.formatted(with: .monthYear)].joined(separator: " ")
    }
}
