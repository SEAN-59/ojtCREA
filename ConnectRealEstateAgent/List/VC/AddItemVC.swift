//
//  AddItemVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class AddItemVC: UIViewController {
    
    private var addressData: Dictionary<AnyHashable, Any> = [:]
    private var addressCd: String = ""

    @IBOutlet weak var searchView: SearchAddressView!
    @IBOutlet weak var informationView: InformationView!
    @IBOutlet weak var investInputView: InvestInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.searchViewSetDelegate()
        hideKeyboard()
    }
    
    private func searchViewSetDelegate() {
        searchView.delegate = self
        [
            searchView.etcTxf,
            searchView.cityTxf,
            searchView.sggTxf,
            searchView.emdTxf
        ].forEach({
            $0?.delegate = self
        })
        
        [
            searchView.cityTxf,
            searchView.sggTxf,
            searchView.emdTxf
        ].forEach({
            $0?.isUserInteractionEnabled = false
        })
    }
    
    private func layout() {
        [
            self.searchView.layer,
            self.informationView.layer,
            self.investInputView.layer
        ].forEach({
            $0.borderWidth = 1
            $0.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
            $0.cornerRadius = 5
        })
    }

    @IBAction func tapGoBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
// MARK: - SAVE PART
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        let saveInvest = self.investInputView.saveData()
        // 여기서 투자 분석 정보 받아 왔으니 DB 저장 하면 됨
    }
}

extension AddItemVC: EndSearchAddress {
    func checkData(data: Dictionary<AnyHashable, Any>, check: Bool, addressCd: String) {
        if check {
            self.addressData = data
            self.addressCd = addressCd
            self.informationView.getData(data: data)
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.searchView.initTextfield()
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "주소 오류",
                                    message: "맞지 않는 주소입니다.\n확인 후 다시 입력해주세요.",
                                    actionArray: actionArray)
        }
    }
}

extension AddItemVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}

