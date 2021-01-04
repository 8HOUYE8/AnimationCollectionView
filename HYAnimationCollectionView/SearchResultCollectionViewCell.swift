//
//  SearchResultCollectionViewCell.swift
//  DrugShop
//
//  Created by house house on 2020/11/19.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    var saleIcon: UIImageView!
    var otc: UIImageView!
    var icon: UIImageView!
    var mainTitle: UILabel!
    var companyName: UILabel!
    var price: UILabel!
    var minumPrice: UILabel!
    var animation = false

    var listTwoForRow = Bool(){
        didSet{
            if listTwoForRow {
                if self.animation {
                    UIView.animate(withDuration: 0.25) {
                        self.setupListTwoForRowView()
                    }
                }else{
                    self.setupListTwoForRowView()
                }

            }else{
                if self.animation {
                    UIView.animate(withDuration: 0.25) {
                        self.setupListOneForRowView()
                    }
                }else{
                    self.setupListOneForRowView()
                }

            }
            UIView.animate(withDuration: 0.25) {

                self.contentView.layoutIfNeeded()
            }
        }
    }
    var discountCouponBGView: UIView!
    
    var discounCoupons = [Dictionary<String, String>](){
        didSet{
            print(self.discountCouponBGView.subviews.count)
            if self.discountCouponBGView.subviews.count > 0 {
                self.discountCouponBGView.subviews.forEach({ $0.removeFromSuperview() })
            }
            var orignX = HYFontSize(size: 0)
            var line = 0.0
            let space = HYFontSize(size: 8)

            for i in 0..<discounCoupons.count {
                let couponDic: Dictionary = discounCoupons[i]
                let text = couponDic["content"]!
                let discoutLabel = HouyeLabel(title: text, titleFont: HYFontSize(size: 18), textColor: redTextColor, superView: self.discountCouponBGView)
                discoutLabel.layer.cornerRadius = HYFontSize(size: 4)
                discoutLabel.layer.masksToBounds = true
                discoutLabel.layer.borderWidth = HYFontSize(size: 1)
                let color = ColorConversion(hexString: couponDic["textColor"]!)
                discoutLabel.layer.borderColor = color.cgColor
                discoutLabel.text = text
                discoutLabel.textColor = color
                discoutLabel.layer.setNeedsLayout()
                discoutLabel.textAlignment = .center
                let width = getLabWidth(labelStr: text, font: FontSize(HYFontSize(size: 18)), height: HYFontSize(size: 22)) + HYFontSize(size: 10)
                if self.listTwoForRow {
                    if orignX + width > HYFontSize(size: 300){
                        orignX = HYFontSize(size: 0)
                        line += 1
                    }
                    print(line)
                    discoutLabel.snp.makeConstraints { (make) in
                        make.top.equalToSuperview().offset(HYFontSize(size: 8) + CGFloat(line) * HYFontSize(size: 30))
                        make.left.equalToSuperview().offset(orignX)
                        make.size.equalTo(CGSize(width: width, height: HYFontSize(size: 22)))
                    }
                    orignX = orignX + width + space
                
                    validateHeight = CGFloat(line + 1) * HYFontSize(size: 26)
                    print(validateHeight!)
                    print(HYFontSize(size: validateHeight*2))
                    discountCouponBGView.snp.remakeConstraints { (make) in
                        make.top.equalTo(minumPrice.snp.bottom).offset(HYFontSize(size: 10))
                        make.left.equalTo(mainTitle.snp.left)
                        make.size.equalTo(CGSize(width: HYFontSize(size: 300), height: HYFontSize(size: validateHeight*2)))

                    }
                  
                }else{
                    if orignX + width > HYFontSize(size: 400){
                        orignX = HYFontSize(size: 0)
                        line += 1
                    }

                    discoutLabel.snp.makeConstraints { (make) in
                        make.top.equalToSuperview().offset(HYFontSize(size: 8) + CGFloat(line) * HYFontSize(size: 30))
                        make.left.equalToSuperview().offset(orignX)
                        make.size.equalTo(CGSize(width: width, height: HYFontSize(size: 22)))
                    }
                    orignX = orignX + width + space
                    validateHeight = CGFloat(line + 1) * HYFontSize(size: 26)
                    print(validateHeight!)
                    discountCouponBGView.snp.remakeConstraints { (make) in
                        make.top.equalTo(minumPrice.snp.bottom).offset(HYFontSize(size: 10))
                        make.left.equalTo(mainTitle.snp.left)
                        make.size.equalTo(CGSize(width: HYFontSize(size: 400), height: HYFontSize(size: validateHeight*2)))
                    }
                
                }
                
            }
            
        }
    }
    var validate: UILabel!
    var shopBtn: UIButton!
    var validateHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        icon = UIImageView()
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(HYFontSize(size: 30))
            make.left.equalToSuperview().offset(HYFontSize(size: 30))
            make.size.equalTo(CGSize(width: HYFontSize(size: 224), height: HYFontSize(size: 224)))
        }
        
        saleIcon = UIImageView()
        saleIcon.image = UIImage(named: "sale")
        self.contentView.addSubview(saleIcon)
        saleIcon.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.left)
            make.size.equalTo(CGSize(width: HYFontSize(size: 54), height: HYFontSize(size: 54)))
        }
        
        otc = UIImageView()
        otc.image = UIImage(named: "iocn_otc")
        self.contentView.addSubview(otc)
        otc.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.top).offset(-HYFontSize(size: 6))
            make.right.equalTo(icon.snp.right)
            make.size.equalTo(CGSize(width: HYFontSize(size: 52), height: HYFontSize(size: 28)))
        }
        
        mainTitle = HouyeLabel(title: "薰貂脆皮香酥嫩滑美式牛排", titleFont: HYFontSize(size: 26), textColor: blackColor, superView: self.contentView)
        mainTitle.numberOfLines = 2
        mainTitle.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.right).offset(HYFontSize(size: 16))
            make.width.equalTo(HYFontSize(size: 460))
        }
        
        companyName = HouyeLabel(title: "塞尔维亚纯正原汁原味穆尔草原", titleFont: HYFontSize(size: 20), textColor: ColorConversion(hexString: "#969799"), superView: self.contentView)
        companyName.snp.makeConstraints { (make) in
            make.top.equalTo(mainTitle.snp.bottom).offset(HYFontSize(size: 8))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        price = HouyeLabel(title: "¥27.98", titleFont: HYFontSize(size: 32), textColor: redTextColor, superView: self.contentView)
        price.snp.makeConstraints { (make) in
            make.top.equalTo(companyName.snp.bottom).offset(HYFontSize(size: 20))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        minumPrice = HouyeLabel(title: "最低优惠价 ¥22.00", titleFont: HYFontSize(size: 20), textColor: lightTextColor, superView: self.contentView)
        minumPrice.snp.makeConstraints { (make) in
            make.top.equalTo(price.snp.bottom).offset(HYFontSize(size: 6))
            make.left.equalTo(price.snp.right).offset(HYFontSize(size: 16))
        }
        
        discountCouponBGView = UIView()
        discountCouponBGView.backgroundColor = .white
        self.contentView.addSubview(discountCouponBGView)
        discountCouponBGView.snp.makeConstraints { (make) in
            make.top.equalTo(price.snp.bottom).offset(HYFontSize(size: 10))
            make.left.equalTo(mainTitle.snp.left)
            make.size.equalTo(CGSize(width: HYFontSize(size: 340), height: HYFontSize(size: 2)))
        }
        
        validate = HouyeLabel(title: "有效期至2020-09", titleFont: HYFontSize(size: 20), textColor: lightTextColor, superView: self.contentView)
        validate.snp.makeConstraints { (make) in
            make.top.equalTo(discountCouponBGView.snp.bottom).offset(HYFontSize(size: 10))
            make.left.equalTo(mainTitle.snp.left)
        }
    
        shopBtn = UIButton()
        shopBtn.setBackgroundImage(UIImage(named: "btn_cart_blue"), for: .normal)
        self.contentView.addSubview(shopBtn)
        shopBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(validate.snp.centerY)
            make.right.equalToSuperview().offset(-HYFontSize(size: 24))
            make.size.equalTo(CGSize(width: HYFontSize(size: 44), height: HYFontSize(size: 44)))
            make.bottom.equalToSuperview().offset(-HYFontSize(size: 20))
        }
    }
    
    /**
     *设置一行一个布局
     */
    func setupListOneForRowView() {
        icon.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(HYFontSize(size: 30))
            make.left.equalToSuperview().offset(HYFontSize(size: 30))
            make.size.equalTo(CGSize(width: HYFontSize(size: 224), height: HYFontSize(size: 224)))
        }
        
        saleIcon.snp.remakeConstraints { (make) in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.left)
            make.size.equalTo(CGSize(width: HYFontSize(size: 54), height: HYFontSize(size: 54)))
        }
        
        otc.snp.remakeConstraints { (make) in
            make.top.equalTo(icon.snp.top).offset(-HYFontSize(size: 6))
            make.right.equalTo(icon.snp.right)
            make.size.equalTo(CGSize(width: HYFontSize(size: 52), height: HYFontSize(size: 28)))
        }
        
        mainTitle.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(HYFontSize(size: 30))
            make.left.equalTo(icon.snp.right).offset(HYFontSize(size: 16))
            make.width.equalTo(HYFontSize(size: 460))
        }
        
        companyName.snp.remakeConstraints { (make) in
            make.top.equalTo(mainTitle.snp.bottom).offset(HYFontSize(size: 8))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        price.snp.remakeConstraints { (make) in
            make.top.equalTo(companyName.snp.bottom).offset(HYFontSize(size: 20))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        minumPrice.snp.remakeConstraints { (make) in
            make.centerY.equalTo(price.snp.centerY)
            make.left.equalTo(price.snp.right).offset(HYFontSize(size: 16))
        }
        
        let discoupons = discounCoupons
        discounCoupons = discoupons
        
        validate.snp.remakeConstraints { (make) in
            make.top.equalTo(discountCouponBGView.snp.bottom).offset(HYFontSize(size: 20))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        shopBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(validate.snp.centerY)
            make.bottom.equalToSuperview().offset(-HYFontSize(size: 20))
            make.right.equalToSuperview().offset(-HYFontSize(size: 24))
            make.size.equalTo(CGSize(width: HYFontSize(size: 44), height: HYFontSize(size: 44)))
        }
    }
    
    /**
     *设置一行两个布局
     */
    func setupListTwoForRowView() {
        icon.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(HYFontSize(size: 30))
            make.left.equalToSuperview().offset(HYFontSize(size: 30))
            make.size.equalTo(CGSize(width: HYFontSize(size: 280), height: HYFontSize(size: 280)))
        }
        
        saleIcon.snp.remakeConstraints { (make) in
            make.top.equalTo(icon.snp.top)
            make.left.equalTo(icon.snp.left)
            make.size.equalTo(CGSize(width: HYFontSize(size: 64), height: HYFontSize(size: 64)))
        }
        
        otc.snp.remakeConstraints { (make) in
            make.top.equalTo(icon.snp.top).offset(-HYFontSize(size: 6))
            make.right.equalTo(icon.snp.right)
            make.size.equalTo(CGSize(width: HYFontSize(size: 52), height: HYFontSize(size: 28)))
        }
        
        mainTitle.snp.remakeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(HYFontSize(size: 30))
            make.left.equalTo(icon.snp.left)
            make.width.equalTo(HYFontSize(size: 280))
        }
        
        companyName.snp.remakeConstraints { (make) in
            make.top.equalTo(mainTitle.snp.bottom).offset(HYFontSize(size: 8))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        price.snp.remakeConstraints { (make) in
            make.top.equalTo(companyName.snp.bottom).offset(HYFontSize(size: 20))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        minumPrice.snp.remakeConstraints { (make) in
            make.top.equalTo(price.snp.bottom)
            make.left.equalTo(mainTitle.snp.left)
        }
        
        let discoupons = discounCoupons
        discounCoupons = discoupons
        
        validate.snp.remakeConstraints { (make) in
            make.top.equalTo(discountCouponBGView.snp.bottom).offset(HYFontSize(size: 30))
            make.left.equalTo(mainTitle.snp.left)
        }
        
        shopBtn.snp.remakeConstraints { (make) in
            make.centerY.equalTo(validate.snp.centerY)
            make.bottom.equalToSuperview().offset(-HYFontSize(size: 20))
            make.right.equalToSuperview().offset(-HYFontSize(size: 24))
            make.size.equalTo(CGSize(width: HYFontSize(size: 44), height: HYFontSize(size: 44)))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
