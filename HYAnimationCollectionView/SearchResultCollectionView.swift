//
//  SearchResultCollectionView.swift
//  DrugShop
//
//  Created by house house on 2020/11/19.
//

import UIKit

class SearchResultCollectionView: UIView {

    lazy var listLayout: UICollectionViewFlowLayout = {
        let listLayouts = UICollectionViewFlowLayout()
        listLayouts.minimumLineSpacing = HYFontSize(size: 8);
        listLayouts.minimumInteritemSpacing = HYFontSize(size: 8);
        listLayouts.sectionInset = UIEdgeInsets(top: HYFontSize(size: 6), left: HYFontSize(size: 6), bottom: HYFontSize(size: 6), right: HYFontSize(size: 6));
        return listLayouts
    }()
    
    lazy var gridLayout: UICollectionViewFlowLayout = {
        let gridLayouts = UICollectionViewFlowLayout()
        gridLayouts.minimumLineSpacing = HYFontSize(size: 8);
        gridLayouts.minimumInteritemSpacing = HYFontSize(size: 8);
        gridLayouts.sectionInset = UIEdgeInsets(top: HYFontSize(size: 8), left: HYFontSize(size: 8), bottom: HYFontSize(size: 8), right: HYFontSize(size: 8));
        return gridLayouts
    }()
    var searchresultCell: SearchResultCollectionViewCell!
    
    var listTwoForRow = Bool(){
        didSet{
            if listTwoForRow {
                self.collectionView.setCollectionViewLayout(gridLayout, animated: true)
            }else{
                self.collectionView.setCollectionViewLayout(listLayout, animated: true)
            }
        }
    }
    
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectView = UICollectionView.init(frame: CGRect(x: HYFontSize(size: 12), y:  0, width: ScreenWidth - HYFontSize(size: 24), height: frame.height), collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.backgroundColor = searchItemBgColor
        collectView.showsVerticalScrollIndicator = true
        collectView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: "searchCollectionCell")
        return collectView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = searchItemBgColor
        
        //1111111
        self.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *按屏幕宽度比例设置空间大小
     */
    func HYFontSize(size ofsize: CGFloat) -> CGFloat {
        return  UIScreen.main.bounds.width*ofsize/750.0
    }
    
}

extension SearchResultCollectionView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return goodsList.count
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.searchresultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionCell", for: indexPath) as? SearchResultCollectionViewCell
//        self.searchresultCell.model = self.goodsList[indexPath.row]
        let discoutCouponOne = ["content":"满100000减8000","textColor":"#EE0A24"]
        let discoutCouponTwo = ["content":"平台95折","textColor":"#ED6A0C"]
        let discoutCouponThree = ["content":"满300减50","textColor":"#EE0A24"]
        searchresultCell.discounCoupons = [discoutCouponOne,discoutCouponTwo,discoutCouponThree,discoutCouponOne]
        searchresultCell.icon.image = UIImage(named: "\(indexPath.row%4+1).jpg")
        searchresultCell.backgroundColor = .white
        print(self.listTwoForRow)
        searchresultCell.listTwoForRow = self.listTwoForRow
        return self.searchresultCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
    }
    
//    //设置items大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let medicinName = "内舒拿糠酸莫米(糠酸莫米松鼻内舒拿糠酸莫米松鼻)50μg(0.05%)*140揿…"
        if self.listTwoForRow {
            let mainTitleHeight = getTextHeigh(textStr: medicinName, font: FontSize(HYFontSize(size: 26)), width: HYFontSize(size: 310))
            return CGSize(width: HYFontSize(size: 350), height: HYFontSize(size: 560) + mainTitleHeight)
        }else{
            let mainTitleHeight = getTextHeigh(textStr: medicinName, font: FontSize(HYFontSize(size: 26)), width: HYFontSize(size: 460))
            return CGSize(width: HYFontSize(size: 710), height: HYFontSize(size: 250) + mainTitleHeight)

        }
    }
    
}
