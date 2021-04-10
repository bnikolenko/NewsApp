//
//  ImageCell.swift
//  NewsApp
//
//  Created by Bodia on 04.04.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {
    @IBOutlet weak var imageContainer: UIImageView!
    
    override func prepareForReuse() {
        imageContainer.image = nil
    }
}

extension ImageCell: ArticleModelFillable {
    func fill(with model: ArticleModel) {
        let url = URL(string: model.urlToImage)
        imageContainer.kf.setImage(with: url)
    }
}
