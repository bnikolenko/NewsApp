//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Bodia on 28.02.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func prepareForReuse() {
        articleTitleLabel.text = nil
        descLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
    }
    
    func fill(with model: ArticleModel) {
        articleTitleLabel.text = model.title
        descLabel.text = model.description
    }
}

extension ArticleCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.25) {
            self.cardView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.25) {
            self.cardView.transform = .identity
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.25) {
            self.cardView.transform = .identity
        }
    }
}
