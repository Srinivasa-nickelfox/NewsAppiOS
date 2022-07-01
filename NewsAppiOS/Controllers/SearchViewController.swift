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
    
    // Functions for TableView Delegate and DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table2.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    // Function to instantiate a ViewController with it's identifier's name to navigate further
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! NextViewController
        nextViewController.article = articles[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    // Function for attributing height of Table View Cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table2.delegate = self
        table2.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        table2.register(nib, forCellReuseIdentifier: "cell")
        
        // Function calls for the API Data Fetching and creating a search bar
        fetchTopStories()
        createSearchBar()
        view.backgroundColor = .black
    }
    
    // Function to create a Search bar at the top of SearchViewController
    private let searchVC = UISearchController(searchResultsController: nil)
        
        private func createSearchBar(){
            navigationItem.searchController = searchVC
            searchVC.searchBar.delegate = self
            searchVC.searchBar.searchTextField.textColor = .white
        }
        
    //Function that provides functionality to the search bar to fetch news related to entered keyword
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
    
    //Function to fetch the API Data
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
