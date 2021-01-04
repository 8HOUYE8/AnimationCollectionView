//
//  ViewController.swift
//  HYAnimationCollectionView
//
//  Created by house house on 2021/1/4.
//

import UIKit

class ViewController: UIViewController {
    var searchResultCollectionView: SearchResultCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "瀑布流"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换", style: .plain, target: self, action: #selector(clickToChangeUI))
        setupFallView()
    }

    @objc func clickToChangeUI(){
        self.searchResultCollectionView.listTwoForRow = !self.searchResultCollectionView.listTwoForRow
        let array = self.searchResultCollectionView.collectionView.indexPathsForVisibleItems
        for indexPath in array {
            let searchReslulCell = self.searchResultCollectionView.collectionView.cellForItem(at: indexPath) as? SearchResultCollectionViewCell
            searchReslulCell?.listTwoForRow = self.searchResultCollectionView.listTwoForRow
            searchReslulCell?.animation = true
        }
    }
    
    /**
     *设置流视图
     */
    func setupFallView() {
        
        searchResultCollectionView = SearchResultCollectionView(frame: CGRect(x: HYFontSize(size: 0), y:  HYFontSize(size: 0), width: ScreenWidth, height: ScreenHeight - bottomSafeHeight))
        
        self.view.addSubview(searchResultCollectionView)
    }
    
    
}

