//
//  AgreementViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 8.03.2023.
//

import UIKit
import SnapKit

class AgreementViewController: UIViewController,GeneralViewProtocol, ConstraintRelatableTarget {
    
    var mainScrollView = UIScrollView()
    var agreementTextView = UITextView()
    var upView = UIView()
    
    var agreementText = """
    MEMBERSHIP AGREEMENT
     Last updated: 20/03/2023

    Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - Contract Test - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST - AGREEMENT TEST

     Dispute Resolution: The laws of the Republic of Turkey apply in the resolution of any dispute arising from the implementation or interpretation of this Agreement; Courts of the Republic of Turkey are authorized.
"""
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setupUI()
        layoutUI()
    }
    
    func addTarget() {
    }
    
    func setupUI() {
        upView.createView(backgroundColor: .gray,cornerRadius: 5)
        agreementTextView.text = agreementText
        agreementTextView.font = .Regular_16
        agreementTextView.tintColor = .black
        agreementTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutUI() {
        agreementTextViewConstraints()
        upViewConstraints()
        
    }
    
    func addView() {
        view.addSubview(agreementTextView)
        view.addSubview(upView)
    }
}

//MARK: Constraints
extension AgreementViewController {
    func agreementTextViewConstraints() {
        self.agreementTextView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.height.equalTo(ScreenSize.height)
        }
    }
    
    func upViewConstraints() {
        self.upView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.width.equalTo(80)
            make.height.equalTo(3)
        }
    }
}
