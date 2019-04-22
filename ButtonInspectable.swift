//
//  ButtonInspectable.swift
//  BaseiOS
//
//  Created by Kaan Esin on 14.03.2019.
//  Copyright © 2019 Kaan Esin. All rights reserved.
//

import UIKit

@IBDesignable class ButtonInspectable: UIButton {
    let scaleFactor:CGFloat = 0.3
    
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
    
    @IBInspectable open var titleAttributedText : String {
        get {
            return attributedTitle(for: .normal)?.string ?? "You can use the application limitless. Its price is <b>5$</b> for a week with free trial"
        }
        
        set {
            setButtonText(btnText: newValue)
        }
    }
    
    @IBInspectable open var backColor : UIColor? {
        get {
            return backgroundColor ?? UIColor.green
        }
        
        set {
            backgroundColor = newValue
        }
    }
    
    @IBInspectable open var titleNumberOfLines : Int {
        get {
            return titleLabel?.numberOfLines ?? 0
        }
        
        set {
            titleLabel?.numberOfLines = newValue
        }
    }
    
    @IBInspectable open var titleMinimumScaleFactor : CGFloat {
        get {
            return titleLabel?.minimumScaleFactor ?? scaleFactor
        }
        
        set {
            titleLabel?.minimumScaleFactor = newValue
        }
    }
    
    @IBInspectable open var titleLineBreakmode : Int {
        get {
            return (titleLabel?.lineBreakMode)!.rawValue
        }
        
        set {
            switch newValue {
            case NSLineBreakMode.byClipping.rawValue:
                titleLabel?.lineBreakMode = .byClipping
                break
            case NSLineBreakMode.byCharWrapping.rawValue:
                titleLabel?.lineBreakMode = .byCharWrapping
                break
            case NSLineBreakMode.byWordWrapping.rawValue:
                titleLabel?.lineBreakMode = .byWordWrapping
                break
            case NSLineBreakMode.byTruncatingHead.rawValue:
                titleLabel?.lineBreakMode = .byTruncatingHead
                break
            case NSLineBreakMode.byTruncatingTail.rawValue:
                titleLabel?.lineBreakMode = .byTruncatingTail
                break
            case NSLineBreakMode.byTruncatingMiddle.rawValue:
                titleLabel?.lineBreakMode = .byTruncatingMiddle
                break
            default:
                titleLabel?.lineBreakMode = .byWordWrapping
                break
            }
        }
    }
    
    @IBInspectable open var titleAdjustsFontSizeToFitWidth : Bool {
        get {
            return titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
        set {
            titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
    }
    
    @IBInspectable open var titleEdgeInsetTop : CGFloat {
        get {
            return titleEdgeInsets.top
        }
        set {
            titleEdgeInsets = UIEdgeInsets(top: newValue,
                                           left: titleEdgeInsets.left,
                                           bottom: titleEdgeInsets.bottom,
                                           right: titleEdgeInsets.right)
        }
    }
    
    @IBInspectable open var titleEdgeInsetLeft : CGFloat {
        get {
            return titleEdgeInsets.left
        }
        set {
            titleEdgeInsets = UIEdgeInsets(top: titleEdgeInsets.top,
                                           left:(btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue),
                                           bottom: titleEdgeInsets.bottom,
                                           right: titleEdgeInsets.right)
        }
    }
    
    @IBInspectable open var titleEdgeInsetBottom : CGFloat {
        get {
            return titleEdgeInsets.bottom
        }
        set {
            titleEdgeInsets = UIEdgeInsets(top: titleEdgeInsets.top,
                                           left: titleEdgeInsets.left,
                                           bottom: newValue,
                                           right: titleEdgeInsets.right)
        }
    }
    
    @IBInspectable open var titleEdgeInsetRight : CGFloat {
        get {
            return titleEdgeInsets.right
        }
        set {
            titleEdgeInsets = UIEdgeInsets(top: titleEdgeInsets.top,
                                           left: titleEdgeInsets.left,
                                           bottom: titleEdgeInsets.bottom,
                                           right: (btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue))
        }
    }
    
    @IBInspectable open var titleBackColor : UIColor? {
        get {
            return titleLabel?.backgroundColor ?? UIColor.yellow
        }
        
        set {
            titleLabel?.backgroundColor = newValue
        }
    }
    
    @IBInspectable open var titleCornerRadius : CGFloat {
        get {
            titleLabel?.clipsToBounds = true
            titleLabel?.layer.masksToBounds = true
            layer.cornerRadius = 30.0
            clipsToBounds = true
            layer.masksToBounds = true
            return titleLabel?.layer.cornerRadius ?? 10.0
        }
        
        set {
            titleLabel?.layer.cornerRadius = newValue
            titleLabel?.clipsToBounds = true
            titleLabel?.layer.masksToBounds = true
            layer.cornerRadius = 30.0
            clipsToBounds = true
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable open var titleLabelAlignment : Int {
        get {
            return titleLabel?.textAlignment.rawValue ?? NSTextAlignment.center.rawValue
        }
        set {
            switch newValue {
            case NSTextAlignment.center.rawValue:
                titleLabel?.textAlignment = .center
                break
            case NSTextAlignment.justified.rawValue:
                titleLabel?.textAlignment = .justified
                break
            case NSTextAlignment.left.rawValue:
                titleLabel?.textAlignment = .left
                break
            case NSTextAlignment.right.rawValue:
                titleLabel?.textAlignment = .right
                break
            case NSTextAlignment.natural.rawValue:
                titleLabel?.textAlignment = .natural
                break
            default:
                titleLabel?.textAlignment = .center
                break
            }
        }
    }
    
    @IBInspectable open var btnImage : UIImage? {
        get {
            return image(for: .normal)
        }
        
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable open var imageEdgeInsetTop : CGFloat {
        get {
            return imageEdgeInsets.top
        }
        set {
            imageEdgeInsets = UIEdgeInsets(top: newValue,
                                           left: imageEdgeInsets.left,
                                           bottom: imageEdgeInsets.bottom,
                                           right: imageEdgeInsets.right)
        }
    }
    
    @IBInspectable open var imageEdgeInsetLeft : CGFloat {
        get {
            return imageEdgeInsets.left
        }
        set {
            imageEdgeInsets = UIEdgeInsets(top: imageEdgeInsets.top,
                                           left: (btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue),
                                           bottom: imageEdgeInsets.bottom,
                                           right: imageEdgeInsets.right)
        }
    }
    
    @IBInspectable open var imageEdgeInsetBottom : CGFloat {
        get {
            return imageEdgeInsets.bottom
        }
        set {
            imageEdgeInsets = UIEdgeInsets(top: imageEdgeInsets.top,
                                           left: imageEdgeInsets.left,
                                           bottom: newValue,
                                           right: imageEdgeInsets.right)
        }
    }
    
    @IBInspectable open var imageEdgeInsetRight : CGFloat {
        get {
            return imageEdgeInsets.right
        }
        set {
            imageEdgeInsets = UIEdgeInsets(top: imageEdgeInsets.top,
                                           left: imageEdgeInsets.left,
                                           bottom: imageEdgeInsets.bottom,
                                           right: (btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue))
        }
    }
    
    @IBInspectable open var contentEdgeInsetTop : CGFloat {
        get {
            return contentEdgeInsets.top
        }
        set {
            contentEdgeInsets = UIEdgeInsets(top: newValue,
                                             left: contentEdgeInsets.left,
                                             bottom: contentEdgeInsets.bottom,
                                             right: contentEdgeInsets.right)
        }
    }
    
    @IBInspectable open var contentEdgeInsetLeft : CGFloat {
        get {
            return contentEdgeInsets.left
        }
        set {
            contentEdgeInsets = UIEdgeInsets(top: contentEdgeInsets.top,
                                             left: (btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue),
                                             bottom: contentEdgeInsets.bottom,
                                             right: contentEdgeInsets.right)
        }
    }
    
    @IBInspectable open var contentEdgeInsetBottom : CGFloat {
        get {
            return contentEdgeInsets.bottom
        }
        set {
            contentEdgeInsets = UIEdgeInsets(top: contentEdgeInsets.top,
                                             left: contentEdgeInsets.left,
                                             bottom: newValue,
                                             right: contentEdgeInsets.right)
        }
    }
    
    @IBInspectable open var contentEdgeInsetRight : CGFloat {
        get {
            return contentEdgeInsets.right
        }
        set {
            contentEdgeInsets = UIEdgeInsets(top: contentEdgeInsets.top,
                                             left: contentEdgeInsets.left,
                                             bottom: contentEdgeInsets.bottom,
                                             right: (btnSemanticContentAttribute == UISemanticContentAttribute.forceRightToLeft.rawValue ? -newValue : newValue))
        }
    }
    
    @IBInspectable open var btnSemanticContentAttribute : Int {
        get {
            return semanticContentAttribute.rawValue
        }
        set {
            switch newValue {
            case UISemanticContentAttribute.forceLeftToRight.rawValue:
                contentHorizontalAlignment = .left
                semanticContentAttribute = .forceLeftToRight
                break
            case UISemanticContentAttribute.forceRightToLeft.rawValue:
                contentHorizontalAlignment = .right
                semanticContentAttribute = .forceRightToLeft
                break
            case UISemanticContentAttribute.spatial.rawValue:
                semanticContentAttribute = .spatial
                break
            case UISemanticContentAttribute.playback.rawValue:
                semanticContentAttribute = .playback
                break
            case UISemanticContentAttribute.unspecified.rawValue:
                semanticContentAttribute = .unspecified
                break
            default:
                semanticContentAttribute = .forceLeftToRight
                break
            }
        }
    }
    
    @IBInspectable open var contentVertical : Int {
        get {
            return contentVerticalAlignment.rawValue
        }
        set {
            switch newValue {
            case UIControl.ContentVerticalAlignment.center.rawValue:
                contentVerticalAlignment = .center
                break
            case UIControl.ContentVerticalAlignment.top.rawValue:
                contentVerticalAlignment = .top
                break
            case UIControl.ContentVerticalAlignment.bottom.rawValue:
                contentVerticalAlignment = .bottom
                break
            case UIControl.ContentVerticalAlignment.fill.rawValue:
                contentVerticalAlignment = .fill
                break
            default:
                contentVerticalAlignment = .center
                break
            }
        }
    }
    
    @IBInspectable open var contentHorizontal : Int {
        get {
            return contentHorizontalAlignment.rawValue
        }
        set {
            switch newValue {
            case UIControl.ContentHorizontalAlignment.center.rawValue:
                contentHorizontalAlignment = .center
                break
            case UIControl.ContentHorizontalAlignment.left.rawValue:
                contentHorizontalAlignment = .left
                break
            case UIControl.ContentHorizontalAlignment.right.rawValue:
                contentHorizontalAlignment = .right
                break
            case UIControl.ContentHorizontalAlignment.fill.rawValue:
                contentHorizontalAlignment = .fill
                break
            default:
                contentHorizontalAlignment = .center
                break
            }
            
            if #available(iOS 11.0, *) {
                if newValue == UIControl.ContentHorizontalAlignment.leading.rawValue {
                    contentHorizontalAlignment = .leading
                }
                else if newValue == UIControl.ContentHorizontalAlignment.trailing.rawValue {
                    contentHorizontalAlignment = .trailing
                }
            }
        }
    }
}
