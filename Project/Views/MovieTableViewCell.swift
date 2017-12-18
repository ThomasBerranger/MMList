//
//  MovieTableViewCell.swift
//  Project
//
//  Created by Thomas BERRANGER on 08/12/2017.
//  Copyright © 2017 Thomas BERRANGER. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with movie:Movie) {
        titleLabel.text = movie.title
        synopsisLabel.text = movie.synopsis
        dateLabel.text = dateFormatter.string(from: movie.date)
    }

}
