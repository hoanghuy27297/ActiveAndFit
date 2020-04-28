//
//  FacilitiesTableViewCell.swift
//  ActiveAndFit
//
//  Created by Huy Hoang on 27/4/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class FacilitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var facilityImage: UIImageView!
    @IBOutlet weak var facilityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
