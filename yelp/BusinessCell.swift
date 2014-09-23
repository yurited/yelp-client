//
//  BusinessCell.swift
//  yelp
//
//  Created by Li Yu on 9/22/14.
//  Copyright (c) 2014 Li Yu. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var bizImage: UIImageView!
    @IBOutlet weak var bizNameLabel: UILabel!
    @IBOutlet weak var bizAddressLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
