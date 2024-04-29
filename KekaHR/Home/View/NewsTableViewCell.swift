//
//  NewsTableViewCell.swift
//  KekaHR
//
//  Created by Naga on 29/04/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgArticle: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayData(doc: Docs) {
        if let imageURL = doc.imageURL {
            imgArticle.simpleLoadImage(imageURL)
        }
        lblTitle.text = doc.headline?.main ?? ""
        lblDescription.text = doc.abstract ?? ""
        lblDate.text = doc.humanReadableDate ?? ""
    }
}
