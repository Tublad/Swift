//
//  GlobalGroupCell.swift
//  Social-Network
//
//  Created by Евгений Шварцкопф on 01.12.2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class GlobalGroupCell: UITableViewCell {
    @IBOutlet weak var globalGroupName: UILabel!
    @IBOutlet weak var globalContent: UILabel!
    @IBOutlet weak var participantGlobal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
