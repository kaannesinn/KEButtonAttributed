//
//  ButtonAttributed.swift
//  BaseiOS
//
//  Created by Kaan Esin on 13.03.2019.
//  Copyright © 2019 Kaan Esin. All rights reserved.
//

import UIKit

class ButtonAttributed: UIButton {
    let scaleFactor:CGFloat = 0.3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonText(btnText: "You can use the application limitless. Its price is <b>5$</b> for a week with free trial")
//        setButtonText(btnText: "CONTINUE")

        backgroundColor = UIColor.green

        titleLabel?.numberOfLines = 0
        titleLabel?.minimumScaleFactor = scaleFactor
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.adjustsFontSizeToFitWidth = false
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left:(UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? -20 : 20),
                                       bottom: 0,
                                       right: 0)
        
        titleLabel?.backgroundColor = UIColor.yellow
        titleLabel?.layer.cornerRadius = 10.0
        titleLabel?.clipsToBounds = true
        titleLabel?.layer.masksToBounds = true
 
        layer.cornerRadius = 30.0
        clipsToBounds = true
        layer.masksToBounds = true
        
        setImage(#imageLiteral(resourceName: "starActive"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        semanticContentAttribute = .forceLeftToRight
        
        titleLabel?.textAlignment = .center
        contentHorizontalAlignment = .left
        contentVerticalAlignment = .center
    }
    
    func setButtonText(btnText:String) {
        var btnText = btnText
        if btnText.contains("<b>") && btnText.contains("</b>") {
            let startRange = (btnText as NSString).range(of: "<b>")
            let finishRange = (btnText as NSString).range(of: "</b>")
            btnText = btnText.replacingOccurrences(of: "<b>", with: "")
            btnText = btnText.replacingOccurrences(of: "</b>", with: "")
            let attr = NSMutableAttributedString(string: btnText)
            attr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSMakeRange(0, btnText.count))
            let boldAttr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: calculateNewFontSize(fontSize: 26), weight: .bold),
                            NSAttributedString.Key.foregroundColor : UIColor.red]
            attr.addAttributes(boldAttr as [NSAttributedString.Key : Any], range: NSMakeRange(startRange.location, finishRange.location - (startRange.location + startRange.length)))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byWordWrapping
            attr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, btnText.count))
            setAttributedTitle(attr, for: .normal)
        }
        else {
            setTitle(btnText, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: calculateNewFontSize(fontSize: 26))
        }
        
        setTitleColor(UIColor.blue, for: .normal)
    }
    
    func calculateNewFontSize(fontSize: CGFloat) -> CGFloat {
        var newSize: CGFloat = (UIScreen.main.bounds.width*UIScreen.main.bounds.height*fontSize)/(375*667.0)
        if newSize <= fontSize * scaleFactor {
            newSize = fontSize * scaleFactor
        }
        else if newSize >= fontSize {
            newSize = fontSize
        }
        return newSize
    }
}
