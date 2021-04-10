//
//  ArticlesDetailsController.swift
//  NewsApp
//
//  Created by Bodia on 23.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import UIKit

class ArticlesDetailsController: UITableViewController {
    
    enum Row {
        case image
        case author
        case description
        case content
    }
    
    var sections: [[Row]] = [[.image], [.author, .description, .content]]
    var model: ArticleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        tableView.register(UINib(nibName: "AuthorDateCell", bundle: nil), forCellReuseIdentifier: "AuthorDateCell")
        tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        tableView.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: "ContentCell")
    }
    
    @IBAction func openArticleURL(_ sender: Any) {
        guard let url = URL(string: model.url) else { return }
        UIApplication.shared.open(url)
    }
}

extension ArticlesDetailsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section][indexPath.row]
        return createCell(row, indexPath: indexPath)
    }
}

protocol ArticleModelFillable: UITableViewCell {
    func fill(with model: ArticleModel)
}

private extension ArticlesDetailsController {
    func createCell(_ row: Row, indexPath: IndexPath) -> UITableViewCell {
        var cell: ArticleModelFillable
        switch row {
        case .image:
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as!
                ImageCell
        case .author:
            cell = tableView.dequeueReusableCell(withIdentifier: "AuthorDateCell", for: indexPath) as!
                AuthorDateCell
        case .description:
            cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        case .content:
            cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as!
                ContentCell
        }
        cell.fill(with: model)

        return cell
    }
}
