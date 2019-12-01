//
//  FriendCell.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 30.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
