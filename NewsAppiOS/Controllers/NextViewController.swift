//
//  NextViewController.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 30/06/22.
//

import UIKit
import SafariServices

class NextViewController: UIViewController {
    
    var article: Article? = Article(title: "", description: "", url: "", urlToImage: "", publishedAt: "")
    var articles = [Article]()
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = article?.title
        self.subtitleLabel.text = article?.description
        
        if article?.urlToImage != nil
        {
            let url = URL(string: article?.urlToImage ?? "")
            newsImage?.downloadImage(from: url!)
            newsImage.contentMode = .scaleAspectFill
        }
    }
    
    // Function that opens the source of the news on clicking the "Click for more info button"
    
    @IBAction func onClickingButton(_ sender: UIButton) {
        
        guard let url = URL(string: article?.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true )
    }
    
}

// Function that downloads the the image from the API data into local storage and renders it into image view
extension UIImageView {
    func downloadImage( from url: URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"),let data = data, error == nil, let image = UIImage(data: data)
        else {
            return
        }
        DispatchQueue.main.async {
            self.image = image
        }
    })
    dataTask.resume()
    }
}
