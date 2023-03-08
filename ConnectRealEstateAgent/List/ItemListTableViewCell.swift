//
//  ItemListTableViewCell.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var sellLbl: UILabel!
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var ratLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setupLabel(addr: String, sell: String, income: String, rat: String){
//        self.addressLbl.text = addr
//        self.sellLbl.text = sell
//        self.incomeLbl.text = income
//        self.ratLbl.text = rat
//    }
}
