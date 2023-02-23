//
//  SearchAddressView.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit
import DropDown

protocol EndSearchAddress{
    func checkData(data: Dictionary<AnyHashable, Any>, check: Bool, addressCd: String)
    func startSearch()
}

final class SearchAddressView: UIView {
    var delegate: EndSearchAddress?
    
    private var cityCd: Int = 0
    private var sggCd: Int = 0
    private let dropdown = DropDown()
    private var korea = Korea(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
    
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var sggTxf: UITextField!
    @IBOutlet weak var emdTxf: UITextField!
    @IBOutlet weak var etcTxf: UITextField!
    
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
extension SearchAddressView {
    @IBAction func tapCityBtn(_ sender: UIButton) {
        let list = korea.cityNm
        initDropdown(button: sender, data: list)
        
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.cityCd = index
            self?.sggCd = 0
            self?.korea.selectCityNm = item
            self?.korea.selectSggNm = ""
            self?.korea.selectEmdNm = ""
            self?.setupTxf()
            self?.dropdown.clearSelection()
        }
        
        
    }
    
    @IBAction func tapSggBtn(_ sender: UIButton) {
        let list = korea.selectSgg()
        initDropdown(button: sender, data: list)
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.sggCd = index
            self?.korea.selectSggNm = item
            self?.korea.selectEmdNm = ""
            self?.setupTxf()
            self?.dropdown.clearSelection()
        }
    }
    
    @IBAction func tapEmdBtn(_ sender: UIButton) {
        let list = korea.selectEmd()
        initDropdown(button: sender, data: list)
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.korea.selectEmdNm = item
            self?.setupTxf()
            self?.dropdown.clearSelection()
        }
    }
    
    @IBAction func tapSearchBtn(_ sender: UIButton) {
        let search = SearchAddress()
        search.delegate = self
        guard let etcText = etcTxf.text else { return }
        let address = "\(korea.selectCityNm) \(korea.selectSggNm) \(korea.selectEmdNm) \(etcText)"
        print(address)
        self.delegate?.startSearch()
        search.choiceRoad(address)
    }
}

extension SearchAddressView {
    private func initDropdown(button: UIButton, data: [String]) {
        dropdown.dataSource = data
        dropdown.anchorView = button
        dropdown.bottomOffset = CGPoint(x: 0,
                                        y:(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.selectedTextColor = UIColor.red
        dropdown.show()
    }
    
    private func setupTxf() {
        self.cityTxf.text = korea.selectCityNm
        self.sggTxf.text = korea.selectSggNm
        self.emdTxf.text = korea.selectEmdNm
        self.etcTxf.text = ""
    }
    
    func initTextfield() {
        self.korea = .init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
        self.setupTxf()
    }

}

extension SearchAddressView: SendAPIDataDelegate {
    func getAPIData(json data: [AnyHashable : Any]) {
        print("load END")
        let addressCd = "\(String(format: "%02d", self.cityCd))\(String(format:"%02d",self.sggCd))"
        if data.isEmpty {
            self.delegate?.checkData(data: data, check: false,addressCd: addressCd)
        } else {
            self.delegate?.checkData(data: data, check: true,addressCd: addressCd)
        }
        
    }
}
