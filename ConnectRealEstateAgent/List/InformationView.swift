//
//  InformationView.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/16.
//

import UIKit

class InformationView: UIView {
    private var apiData: Dictionary <AnyHashable, Any> = [:]
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var platAreaLbl: UILabel!
    @IBOutlet weak var archAreaLbl: UILabel!
    @IBOutlet weak var totAreaLbl: UILabel!
    @IBOutlet weak var vlRatLbl: UILabel!
    @IBOutlet weak var grndFlrLbl: UILabel!
    @IBOutlet weak var ugrndFlrLbl: UILabel!
    @IBOutlet weak var useAprLbl: UILabel!
    @IBOutlet weak var mainPurpsLbl: UILabel!
    
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
    
    func getData(data: Dictionary<AnyHashable, Any>) {
        self.apiData = data
        self.setLabelData()
    }
    
}

extension InformationView {
    private func setLabelData() {
        self.addressLbl.text = self.apiData["oldAddress"] as? String
        self.platAreaLbl.text = self.apiData["platArea"] as? String
        self.archAreaLbl.text = self.apiData["archArea"] as? String
        self.totAreaLbl.text = self.apiData["totArea"] as? String
        self.vlRatLbl.text = self.apiData["vlRat"] as? String
        self.mainPurpsLbl.text = self.apiData["mainPurpsCdNm"] as? String
        self.grndFlrLbl.text = self.apiData["grndFlrCnt"] as? String
        self.ugrndFlrLbl.text = self.apiData["ugrndFlrCnt"] as? String
        self.useAprLbl.text = self.apiData["useAprDay"] as? String
    }
}
