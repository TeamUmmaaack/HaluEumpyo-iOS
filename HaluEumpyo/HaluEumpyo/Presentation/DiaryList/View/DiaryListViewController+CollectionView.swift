//
//  DiaryListViewController+CollectionView.swift
//  HaluEumpyo
//
//  Created by 배소린 on 2022/05/29.
//

import Foundation
import UIKit

extension DiaryListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: DrawerCollectionReusableView.self), for: indexPath)
            return headerView
        default:
            assert(false, "에러")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
//        let diaryViewController = DiaryViewController(diary: diaries[item], locale: "en_US")
        let diaryViewController = DiaryViewController(with: DiaryItemViewModel(with: diaries[item], locale: "en_US"))
        navigationController?.pushViewController(diaryViewController, animated: true)
    }
}

extension DiaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diaries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DiaryListCollectionViewCell.self), for: indexPath) as? DiaryListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.containerView.layer.applyShadow(color: UIColor.black, alpha: 0.06, x: 0, y: 4, blur: 10, spread: 0)
        cell.setData(from: diaries[indexPath.row])
        
        return cell
    }
}

extension DiaryListViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
