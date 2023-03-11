//
//  InvestInfoView.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

import UIKit

class InvestInfoView: UIView {
    @IBOutlet weak var sellLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var loanLbl: UILabel!
    @IBOutlet weak var interestLbl: UILabel!
    @IBOutlet weak var monthIncomeLbl: UILabel!
    @IBOutlet weak var yearIncomeLbl: UILabel!
    @IBOutlet weak var realInvestLbl: UILabel!
    @IBOutlet weak var investRatLbl: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
    }
    
    private func loadNib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let nibView = nibs?.first as? UIView else { return }
        nibView.frame = self.bounds
        self.addSubview(nibView)
    }

}
