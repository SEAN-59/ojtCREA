//
//  DropBoxCell.swift
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/15.
//

import UIKit

class DropBoxCell: UITableViewCell {
    
    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        cellLbl.textColor = .systemRed
        // Configure the view for the selected state
    }
    
}
