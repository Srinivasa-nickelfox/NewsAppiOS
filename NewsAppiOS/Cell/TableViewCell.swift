//
//  TableViewCell.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            titleLabel.text = nil
            subtitleLabel.text = nil
            newsImage.image = nil
        }
    
    func configure(with viewModel: NewsTableViewCellModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
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
