//
//  CollectionViewCell.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 01/07/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Function for making the default value of title, subtitle and image to be empty/nil
    // To avoid the repetition of previous data
    
    override func prepareForReuse() {
            super.prepareForReuse()
            titleLabel.text = nil
            newsImage.image = nil
        }
    
    // Function that configures/passes the fetched API data into respective views' cells
    
    func configure(with viewModel: CustomCellModel){
        titleLabel.text = viewModel.title
        
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }
            .resume()
        }
        
    }

}
