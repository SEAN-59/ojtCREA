//
//  AddItemVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class AddItemVC: UIViewController {

    @IBOutlet weak var searchView: SearchAddressView!
    
    @IBOutlet weak var informationView: InformationView!
    
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
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.searchView.layer.cornerRadius = 5
        
        self.informationView.layer.borderWidth = 1
        self.informationView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        self.informationView.layer.cornerRadius = 5
    }

    @IBAction func tapGoBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}

extension AddItemVC: EndSearchAddress {
    func checkData(data: Dictionary<AnyHashable, Any>, check: Bool) {
        if check {
            // 데이터 받아오면 여기서 이제 갈랒
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


//
