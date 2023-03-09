//
//  AddressSearchView.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/06.
//

import UIKit
import DropDown
protocol MoveMapDelegate {
    func getSearchGeo(lat: Double, lon: Double)
}


class AddrSearchView: UIView {
    var delegate: MoveMapDelegate?
    private let dropdown = DropDown()
    private var korea = Korea(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
    private let searchAPI = SearchAddress()
    
    private var cityCd: Int = 0
    private var sggCd: Int = 0
    private var emdCd: Int = 0
    
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var sggTxf: UITextField!
    @IBOutlet weak var emdTxf: UITextField!
    
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
        self.searchAPI.delegate = self
    }
    
    @IBAction func tapCityBtn(_ sender: UIButton) {
        let list = korea.cityNm
        initDropdown(button: sender, data: list)
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
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
        if !korea.selectCityNm.isEmpty {
            if !korea.selectSggNm.isEmpty {
                if !korea.selectEmdNm.isEmpty {
                    self.searchAPI.checkGeocode("\(korea.selectCityNm) \(korea.selectSggNm) \(korea.selectEmdNm)",addrCd: "00")
                    self.initTextfield()
                    
                }
            }
        }
    }
    
    
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
    }
    
    func initTextfield() {
        self.korea = .init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
        self.setupTxf()
    }
}

extension AddrSearchView: SendAPIDataDelegate {
    func getGeocodingAPI(geo data: [AnyHashable : Any], addrcd addrCd: String, address: String) {
        guard let lat = data["lat"] as? String else { return print("Convert Error lat") }
        guard let lon = data["lon"] as? String else { return print("Convert Error lon")}
        
        self.delegate?.getSearchGeo(lat: Double(lat)!,
                                    lon: Double(lon)!)
    }
}
