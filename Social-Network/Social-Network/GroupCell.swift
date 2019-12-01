//
//  GroupCell.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 30.11.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var participant: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
