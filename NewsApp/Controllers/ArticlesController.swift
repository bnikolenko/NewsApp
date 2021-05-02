//
//  ArticlesController.swift
//  NewsApp
//
//  Created by Bodia on 13.02.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//
import CoreData
import UIKit

class ArticlesController: UITableViewController {
    
    enum DisplayState {
        case empty
        case notFound
        case data
    }
    
    let networkManager = NetworkManager()
    
    private var model: ArticlesListModel?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        
        tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        filterContentForSearchText(nil)
    }

    @IBAction func saveArticle(_ sender: Any) {

    }
}

extension ArticlesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prepare(for: resolveDataState())
        return model?.articles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        if let article = model?.articles[indexPath.row] {
            cell.fill(with: article)
        }
        return cell
    }
}

extension ArticlesController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article = model?.articles[indexPath.row] else { return }
        performSegue(withIdentifier: "toDetails", sender: article)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let article = sender as? ArticleModel,
              let destination = segue.destination as? ArticlesDetailsController else { return }
        destination.model = article
    }
}

extension ArticlesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }
    
    private func filterContentForSearchText(_ searchText: String?) {
        let backMonthDate = Date(timeIntervalSince1970: (Date().timeIntervalSince1970 - 604800))
        let request = ArticlesRequest(query: searchText, from: backMonthDate, to: Date(), sortBy: "popularity")
        networkManager.fetch(request: request) { [weak self] (result: Swift.Result<ArticlesListModel, Error>) in
            switch result {
            case .success(let model):
                self?.model = model
            case .failure(let error):
                self?.model = nil
                //print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//displayStateMachine
private extension ArticlesController {
    func resolveDataState() -> DisplayState {
        switch (searchBarIsEmpty, model == nil) {
        case (true, true), (true, false):
            return .empty
        case (false, true):
            return .notFound
        case (false, false):
            return .data
        }
    }
    
    func prepare(for state: DisplayState) {
        switch state {
        case .empty:
            tableView.setNoDataPlaceholder("Try to search something")
        case .notFound:
            tableView.setNoDataPlaceholder("Articles not found. \nTry to change your search request")
        case .data:
            tableView.removeNoDataPlaceholder()
        }
    }
}


extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 17)
        label.sizeToFit()
        self.isScrollEnabled = false
        self.backgroundView = label
    }
    
    func removeNoDataPlaceholder() {
           self.isScrollEnabled = true
           self.backgroundView = nil
       }
}
//detailsScreen
