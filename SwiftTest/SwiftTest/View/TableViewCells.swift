//
//  TableViewCells.swift
//  swiftlearning
//
//  Created by Ranjith Karuvadiyil on 31/01/19.
//  Copyright © 2019 mistybits. All rights reserved.
//

import UIKit

class TableViewCells: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var titleImage: UIImageView?

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
