//
//  Marco.swift
//  HYAnimationCollectionView
//
//  Created by house house on 2021/1/4.
//

import UIKit
import SnapKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let navigationHeight:CGFloat = ((ScreenHeight >= 812.0) ? 88.0 : 64.0)
let bottomSafeHeight:CGFloat = ((ScreenHeight >= 812.0) ? 34.0 : 0.0)
let tabBarHeight:CGFloat = ((ScreenHeight >= 812.0) ? 83.0 : 49.0)
let searchItemBgColor = ColorConversion(hexString: "#F7F8FA")

let redTextColor = ColorConversion(hexString: "#EE0A24")
let blackColor = ColorConversion(hexString: "#333333")
let lightTextColor = ColorConversion(hexString: "#969799")

//font
func FontSize(_ ofSize:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: ofSize)
}

func ColorConversion(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
    var str:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
    if hexString.hasPrefix("#"){
        str = (hexString as NSString).substring(from: 1) as NSString
    }
    
    let redStr = (str as NSString ).substring(to: 2)
    let greenStr = ((str as NSString).substring(from: 2) as NSString).substring(to: 2)
    let blueStr = ((str as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: redStr).scanHexInt32(&r)
    Scanner(string: greenStr).scanHexInt32(&g)
    Scanner(string: blueStr).scanHexInt32(&b)
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
}

/**
 *按屏幕宽度比例设置空间大小
 */
func HYFontSize(size ofsize: CGFloat) -> CGFloat {
    return  UIScreen.main.bounds.width*ofsize/750.0
}


/**
 *计算label文字高度
 */
func getTextHeigh(textStr :  String, font : UIFont, width : CGFloat)  -> CGFloat{
    
    let normalText : NSString = textStr as NSString
    
    let size = CGSize(width: width, height:1000)   //CGSizeMake(width,1000)
    
    let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
    
    let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
    
    return  stringSize.height
    
}

/**
 *计算label文字宽度
 */
func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
    
    let statusLabelText = labelStr
    
    let size = CGSize(width: 900, height: height)
    
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)

    let stringSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
    
    return stringSize.width
    
}


/**
 *初始化label
 */
func HouyeLabel(title: String, titleFont: CGFloat, textColor: UIColor, superView: UIView) -> UILabel{
    
    let label = UILabel()
    label.text = title
    label.font = UIFont.systemFont(ofSize: titleFont)
    label.textColor = textColor
    superView.addSubview(label)
    
    return label
    
}
