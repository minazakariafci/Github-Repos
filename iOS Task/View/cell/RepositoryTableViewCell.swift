//
//  RepositoryTableViewCell.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // SetData
    func setData(repos: RepositoryModel){
        titleLabel.text = repos.name
        descriptionLabel.text = repos.description
        forksCountLabel.text = String(repos.forksCount ?? 0)
        languageLabel.text = repos.language
        creationDateLabel.text = repos.createdAt
        if let urlString = repos.owner?.avatarUrl , let url = URL(string: urlString){
            userImageView.kf.setImage(with: url)
        }
    }
}
