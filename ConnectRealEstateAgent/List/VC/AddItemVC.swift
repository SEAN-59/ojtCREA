//
//  AddItemVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class AddItemVC: CREAViewController {
    
    private var addressData: Dictionary<AnyHashable, Any> = [:]
    private var addressCd: String = ""

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
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
        self.informationView.informationView.isHidden.toggle()
        self.investInputView.investView.isHidden.toggle()
    }

    @IBAction func tapGoBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
// MARK: - SAVE PART
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        let dbManger = DatabaseManager()
        dbManger.delegate = self
        
        self.loadingAction()
        /// 여기서 투자 분석 정보 받아 왔으니 DB 저장 하면 됨
        let saveInvest = self.investInputView.saveData()
        /// self.addressCd 는 areaData 의 구분을 위해서 사용
        /// self.addressData 는 itemData 에 저장을 위해서 사용
        let allDict = self.addressData.merging(saveInvest, uniquingKeysWith: {(_, new) in new}).merging(["addressCd":self.addressCd], uniquingKeysWith: {(_, new) in new})
        dbManger.createData(type: .area, data: self.addressCd)
        dbManger.createData(type: .item, data: allDict)
        
    }
    
    
    private func loadingAction(){
        self.backView.isHidden.toggle()
        self.searchIndicator.isHidden.toggle()
        
        if self.searchIndicator.isAnimating == true {
            self.searchIndicator.stopAnimating()
        } else {
            self.searchIndicator.startAnimating()
        }
    }
}

extension AddItemVC: EndSearchAddress {
    func checkData(data: Dictionary<AnyHashable, Any>, check: Bool, addressCd: String) {
        if check {
            self.addressData = data
            self.addressCd = addressCd
            
            self.informationView.getData(data: data)
            self.informationView.informationView.isHidden.toggle()
            self.investInputView.investView.isHidden.toggle()
            
            self.loadingAction()
            
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.searchView.initTextfield()
                self.loadingAction()
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "주소 오류",
                                    message: "맞지 않는 주소입니다.\n확인 후 다시 입력해주세요.",
                                    actionArray: actionArray)
        }
    }
    
    func startSearch() {
        self.loadingAction()
    }
}

extension AddItemVC: DatabaseCallDelegate {
    func successSaveDB(result: Bool) {
        if result {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.loadingAction()
                self.dismiss(animated: true, completion: nil)
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "저장 완료",
                                    message: "데이터가 저장되었습니다.",
                                    actionArray: actionArray)
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.loadingAction()
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "저장 에러",
                                    message: "데이터가 저장에 문제가 발생했습니다.",
                                    actionArray: actionArray)
            
        }
    }
    
}

extension AddItemVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}

