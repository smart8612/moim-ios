//
//  FriendTableViewCell.swift
//  moim
//
//  Created by JeongTaek Han on 28/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet var friendProfileImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendStatusLabel: UILabel!
    @IBOutlet var friendAddButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
