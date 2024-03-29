//
//  ViewController.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import UIKit
import ReactiveSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    //var articles = [Article]()
    //var viewModels = [NewsTableViewCellModel]()
    
    var apiKey = "e7855adfcfbb4dd69e3fd27172d1aa4e"
    private var viewModels = [CustomCellModel]()
    private var articles = [Article]()
    var disposable = CompositeDisposable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
                newsCollectionView.delegate = self
                newsCollectionView.dataSource = self
                let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
                newsCollectionView.register(nib, forCellWithReuseIdentifier: "cell1")
        
                self.setupObservers()
                self.getData()
        // Function call for the API Data Fetching
        //fetchTopStories()
    }
    
    // Function to fetch the API Data
    
   /* private func fetchTopStories() {
        NewsAPIClient.shared.fetch { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.map({
                    NewsTableViewCellModel(title: $0.title ?? "No Title",
                                               subtitle: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "https://demofree.sirv.com/nope-not-here.jpg?w=150"))
                })
                DispatchQueue.main.async {
                    self?.newsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }

        }
    }*/
    private func getData() {
        let params: [String:Any] = [
            
            "apiKey": self.apiKey,
            "q": "apple",
            //"country": "in",
            "from": "2022-07-19",
            "to": "2022-07-19",
            "sortBy": "popularity"

        ]
        self.fetchNewsAction.apply(params).start()

    }
    
    private let fetchNewsAction = Action { (params: [String:Any]) -> SignalProducer<[Article], ModelError> in
        return Article.fetch(params: params)
    }
    
    private func setupObservers() {
        self.disposable += self.fetchNewsAction.values.observeValues(
            { [weak self] (articles) in

                    self?.articles = articles
                self?.viewModels = articles.map({CustomCellModel(title: $0.title ?? "No title", subtitle: $0.description ?? "No description", imageURL: URL(string: $0.urlToImage ??  "")
                    )
                        
                    })
                    
                    DispatchQueue.main.async {
                        self?.newsCollectionView.reloadData()
                       
                        
                    }

                })
        self.disposable += self.fetchNewsAction.errors.observeValues({(error) in
            print(error)
    })
    }
}

// Functions for CollectionView Delegate and DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    // Function to instantiate a ViewController with it's identifier's name to navigate further
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as!  NextViewController
        nextViewController.article = articles[indexPath.row]
        self.present(nextViewController, animated:true, completion:nil)
    }
}

//if let nextViewController = storyBoard.instantiateInitialViewController(withIdentifier: "nextView") as NextViewController
//    else

// Functions attributing the height of collectionViewCell, no. of cells in each row, spacing between the cells in same row and different row

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width/2 - 1, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


