//
//  SearchViewController.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 30/06/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var table2: UITableView!
    
    var articles = [Article]()
    var viewModels = [NewsTableViewCellModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table2.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let article = articles[indexPath.row]
//
//        guard let url = URL(string: article.url ?? "") else {
//            return
//        }
//        let vc = SFSafariViewController(url: url)
//        present(vc,animated: true )

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! NextViewController
        nextViewController.article = articles[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table2.delegate = self
        table2.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        table2.register(nib, forCellReuseIdentifier: "cell")
        
        fetchTopStories()
        createSearchBar()
        view.backgroundColor = .systemOrange
    }
    
    private let searchVC = UISearchController(searchResultsController: nil)
        
        private func createSearchBar(){
            navigationItem.searchController = searchVC
            searchVC.searchBar.delegate = self
            searchVC.searchBar.searchTextField.textColor = .white
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let text = searchBar.text, !text.isEmpty else{
                return
            }
            APIFetcher.shared.search(with: text) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.viewModels = articles.compactMap({
                        NewsTableViewCellModel(title: $0.title ?? "No Title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                    })

                    DispatchQueue.main.async {
                        self?.table2.reloadData()
                        self?.searchVC.dismiss(animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    private func fetchTopStories() {
        APIFetcher.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellModel(title: $0.title ?? "No Title",
                                               subtitle: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                })
                DispatchQueue.main.async {
                    self?.table2.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
   
}
