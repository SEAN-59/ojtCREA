//
//  InvestInputView.swift
//
//
//  Created by TAnine on 2023/02/17.
//

import UIKit

class InvestInputView: UIView {

    @IBOutlet weak var sellValueTxf: UITextField!
    @IBOutlet weak var depositValueTxf: UITextField!
    @IBOutlet weak var loanValueTxf: UITextField!
    @IBOutlet weak var loanRatTxf: UITextField!
    @IBOutlet weak var incomeValueTxf: UITextField!
    
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
    
    func saveData() -> InvestData {
        var result: InvestData = .init(sellValue: 0, depositValue: 0, loanValue: 0, loanRat: 0, incomeValue: 0)
        
        let doubleArray: [Double] = [
            self.sellValueTxf.text,
            self.depositValueTxf.text,
            self.loanValueTxf.text,
            self.loanRatTxf.text,
            self.incomeValueTxf.text
        ].map({
            guard let stringValue = $0 else { return 0}
            guard let doubleValue = Double(stringValue) else { return 0}
            return doubleValue
        })
        
        result.sellValue = doubleArray[0]
        result.depositValue = doubleArray[1]
        result.loanValue = doubleArray[2]
        result.loanRat = doubleArray[3]
        result.incomeValue = doubleArray[4]
        return result
    }
}


struct InvestData {
    var sellValue,
        depositValue,
        loanValue,
        loanRat,
        incomeValue :Double
}
