//
//  TodoCell.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/11/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var todoLabel: UILabel!
    
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
