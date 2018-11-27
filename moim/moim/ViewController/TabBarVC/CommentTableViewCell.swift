//
//  CommentTableViewCell.swift
//  moim
//
//  Created by JeongTaek Han on 27/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCommentCell(name: String, comment: String) {
        self.nameLabel.text = name
        self.commentLabel.text = comment
    }

}
