//
//  InvestInputView.swift
//
//
//  Created by TAnine on 2023/02/17.
//

import UIKit

class InvestInputView: UIView {
    @IBOutlet var investView: UIView!
    
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
    
    func saveData() -> Dictionary<AnyHashable, Any>{
        var result: [String: Double] = [:]
        
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
        
        result = ["sell":doubleArray[0],
                  "deposit": doubleArray[1],
                  "loan": doubleArray[2],
                  "loanRat": doubleArray[3],
                  "income": doubleArray[4]
        ]
        
        return result
        
    }
}

