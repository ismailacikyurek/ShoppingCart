//
//  OnBoardingViewController.swift
//  ShopingCart
//
//  Created by İSMAİL AÇIKYÜREK on 6.03.2023.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    
    private let onboardingView = OnBoardingView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = onboardingView
        onboardingView.interface = self
        setupDelegates()
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension OnBoardingViewController : OnboardingViewInterface {
    func onboardingViewSkipButtonTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

//MARK: - CollectionView Methods

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupDelegates() {
        onboardingView.slidesCollectionView.delegate = self
        onboardingView.slidesCollectionView.dataSource = self
        onboardingView.slidesCollectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier:OnBoardingCollectionViewCell.identifier)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingView.slidesModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingView.slidesCollectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as? OnBoardingCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(data: onboardingView.slidesModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardingView.slidesCollectionView.frame.width, height: onboardingView.slidesCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
//MARK: - ScrollView Method

extension OnBoardingViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let screenWitdh = scrollView.frame.width
        onboardingView.currentIndex = Int((scrollView.contentOffset.x / screenWitdh) + 0.1)
    }
}
