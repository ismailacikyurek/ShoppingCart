//
//  LoadingViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 9.03.2023.
//

import UIKit
import Lottie
import SnapKit

class LoadingViewController: UIViewController {
 
    // MARK: UIComponent
    lazy var mainView = UIView()
    private lazy var animationView : LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading-new1", animationCache: .none)
        animationView.contentMode = .scaleToFill
        animationView.animationSpeed = 1.0
        animationView.loopMode = .loop
        animationView.layer.masksToBounds = true
        animationView.layer.cornerRadius = 30
        animationView.translatesAutoresizingMaskIntoConstraints = true
        return animationView
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        addView()
        setupUI()
        layoutUI()
        addTarget()
        animationView.play()
    }
  
}
//MARK: AddSubiew,AddTarget,LayoutUI,SetupUI
extension LoadingViewController : GeneralViewProtocol {
    func addTarget() {}
    
    func setupUI() {
        mainView.createView(backgroundColor: .clear, cornerRadius: 15, clipsToBounds: true)
    }
    
    func layoutUI() {
        mainViewConstraints()
        animationViewConstraints()
    }
    
    func addView() {
        view.addSubview(mainView)
        mainView.addSubview(animationView)
    }
}
//MARK: Constraints
extension LoadingViewController {
    func mainViewConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(130)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(290)
        }
    }
    func animationViewConstraints() {
        animationView.snp.makeConstraints { make in
            make.top.equalTo(mainView).offset(0)
            make.leading.equalTo(mainView.snp.leading).offset(25)
            make.trailing.equalTo(mainView.snp.trailing).offset(-25)
            make.height.equalTo(mainView).offset(-30)
        }
    }
    
}
