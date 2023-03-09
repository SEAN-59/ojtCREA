//
//  InformationView.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/16.
//

import UIKit

class InformationView: UIView {
    private var apiData: Dictionary <AnyHashable, Any> = [:]
    
    @IBOutlet var informationView: UIView!
    
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
        self.platAreaLbl.text = "\(String(describing: self.apiData["platArea"]!)) ㎡"
        self.archAreaLbl.text = "\(String(describing: self.apiData["archArea"]!)) ㎡"
        self.totAreaLbl.text = "\(String(describing: self.apiData["totArea"]!)) ㎡"
        self.vlRatLbl.text = "\(String(describing: self.apiData["vlRat"]!)) %"
        self.grndFlrLbl.text = "\(String(describing: self.apiData["grndFlrCnt"]!)) 층"
        self.ugrndFlrLbl.text = "\(String(describing: self.apiData["ugrndFlrCnt"]!)) 층"
        
        let useApr = self.dayChangeToString(day: String(describing: self.apiData["useAprDay"]!))
        
        if useApr != "" {
            self.useAprLbl.text = "\(useApr)"
        } else {
            self.useAprLbl.text = "확인 되지 않음"
        }
        
        self.mainPurpsLbl.text = "\(String(describing: self.apiData["purpsNm"]!))"
    }
    
    
    private func dayChangeToString(day: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        formatter.dateFormat = "yyyyMMdd"
        guard let stringToDate = formatter.date(from: day) else { return "" }
        
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let dateToString = formatter.string(from: stringToDate)
        
        return dateToString
    }
}
