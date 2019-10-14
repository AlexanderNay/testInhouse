//
//  FeedTableViewCell.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/13/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedImageWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(item: NewsItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.itemDescription
        
        if  item.imageURL != "" {
            let url = URL(string: item.imageURL)
            feedImageWidthConstraint.constant = 50
            feedImageView.kf.setImage(with: url)
        } else {
            feedImageWidthConstraint.constant = 0
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
