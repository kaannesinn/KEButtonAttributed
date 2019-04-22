//
//  ViewButton.swift
//  BaseiOS
//
//  Created by Kaan Esin on 15.03.2019.
//  Copyright © 2019 Kaan Esin. All rights reserved.
//

import UIKit

enum SingleImageHorizontal:Int {
    case Left
    case Right
    case Center
}

enum SingleImageVertical:Int {
    case Top
    case Bottom
    case Center
}

enum SingleLabelHorizontal:Int {
    case Left
    case Right
    case Center
}

enum SingleLabelVertical:Int {
    case Top
    case Bottom
    case Center
}

@IBDesignable class ViewButton: UIView {
    var imageCountOnView: Int = 1
    var labelCountOnView: Int = 1
    var imageNameOnButton: String = "emptyStar"
    var imageOnView: String = "starActive"
    var singleImageHorizontalValue: Int = 0
    var singleImageWidthValue: Int = 30
    var singleImageHeightValue: Int = 30
    var singleImageLeftOffsetValue: Int = 20
    var singleImageVerticalValue: Int = 2
    var singleImageTopOffsetValue: Int = 20
    var labelOnView: String = "You can use the application limitless. Its price is <b>5$</b> for a week with free trial"
    var singleLabelHorizontalValue: Int = 0
    var singleLabelWidthValue: Int = 30
    var singleLabelHeightValue: Int = 30
    var singleLabelLeftOffsetValue: Int = 20
    var singleLabelVerticalValue: Int = 2
    var singleLabelTopOffsetValue: Int = 20
    let scaleFactor:CGFloat = 0.3

    func setButtonText(btnText:String, label: UILabel) {
        label.textColor = UIColor.blue

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
            label.attributedText = attr
        }
        else {
            label.text = btnText
            label.font = UIFont.systemFont(ofSize: calculateNewFontSize(fontSize: 26))
        }
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
    
    @IBInspectable open var imageName : String {
        get {
            return imageNameOnButton
        }
        set {
            imageNameOnButton = newValue
        }
    }

    @IBInspectable open var imageCount : Int {
        get {
            return imageCountOnView
        }
        set {//imageCount=9 viewWidth=200 viewHeight=100 imageWidthHeight=30 -> 30-30-30-30-30-30/30-30-30/
            let widthHeight = 30
            var y = 0
            var x = 0
            
            let tempImg = UIImage(named: self.imageNameOnButton)
            for i in 0..<newValue {
                if (x*widthHeight+widthHeight) > Int(self.bounds.size.width) && x >= (Int(self.bounds.size.width)/widthHeight) {
                    y+=1
                    x=0
                }
                if y*widthHeight+widthHeight > Int(self.bounds.size.height) {
                    break
                }
                
                let img = UIImageView(frame: CGRect(x: x*widthHeight,
                                                    y: y*widthHeight,
                                                    width: widthHeight,
                                                    height: widthHeight))
                x+=1
                img.tag = i
                img.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                img.image = tempImg
                self.addSubview(img)
            }
            imageCountOnView = newValue
        }
    }
    
    @IBInspectable open var labelCount : Int {
        get {
            return labelCountOnView
        }
        set {//imageCount=9 viewWidth=200 viewHeight=100 imageWidthHeight=30 -> 30-30-30-30-30-30/30-30-30/
            let widthHeight = 30
            var y = 0
            var x = 0
            
            for i in 0..<newValue {
                if (x*widthHeight+widthHeight) > Int(bounds.size.width) && x >= (Int(bounds.size.width)/widthHeight) {
                    y+=1
                    x=0
                }
                if y*widthHeight+widthHeight > Int(bounds.size.height) {
                    break
                }
                
                let lbl = UILabel(frame: CGRect(x: x*widthHeight,
                                                    y: y*widthHeight,
                                                    width: widthHeight,
                                                    height: widthHeight))
                x+=1
                lbl.tag = i
                lbl.backgroundColor = UIColor.cyan.withAlphaComponent(0.5)
                lbl.text = String(i+1)
                lbl.textAlignment = .center
                addSubview(lbl)
            }
            
            labelCountOnView = newValue
        }
    }
    
    @IBInspectable open var singleImage: String {
        get {
            return imageOnView
        }
        set {
            let tempImg = UIImage(named: self.imageOnView)
            
            var xValue = singleImageLeftOffsetValue
            if singleImageHorizontalValue == SingleImageHorizontal.Left.rawValue {
                xValue = singleImageLeftOffsetValue
            }
            else if singleImageHorizontalValue == SingleImageHorizontal.Right.rawValue {
                xValue = Int(bounds.size.width) - singleImageWidthValue - singleImageLeftOffsetValue
            }
            else if singleImageHorizontalValue == SingleImageHorizontal.Center.rawValue {
                xValue = (Int(bounds.size.width) - singleImageWidthValue)/2
            }
            
            var yValue = singleImageTopOffsetValue
            if singleImageVerticalValue == SingleImageVertical.Top.rawValue {
                yValue = singleImageTopOffsetValue
            }
            else if singleImageVerticalValue == SingleImageVertical.Bottom.rawValue {
                yValue = Int(bounds.size.height) - singleImageHeightValue - singleImageTopOffsetValue
            }
            else if singleImageVerticalValue == SingleImageVertical.Center.rawValue {
                yValue = (Int(bounds.size.height)-Int(singleImageHeightValue))/2
            }
            
            let img = UIImageView(frame: CGRect(x: xValue,
                                                y: yValue,
                                                width: singleImageWidthValue,
                                                height: singleImageHeightValue))
            img.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            img.image = tempImg
            img.contentMode = .scaleAspectFit
            self.addSubview(img)
            
            imageOnView = newValue
        }
    }
    
    @IBInspectable open var singleImageH: Int {
        get {
            return singleImageHorizontalValue
        }
        set {
            singleImageHorizontalValue = newValue
        }
    }
    
    @IBInspectable open var singleImageV: Int {
        get {
            return singleImageVerticalValue
        }
        set {
            singleImageVerticalValue = newValue
        }
    }
    
    @IBInspectable open var singleImageWidth: Int {
        get {
            return singleImageWidthValue
        }
        set {
            singleImageWidthValue = newValue
        }
    }
    
    @IBInspectable open var singleImageHeight: Int {
        get {
            return singleImageHeightValue
        }
        set {
            singleImageHeightValue = newValue
        }
    }
    
    @IBInspectable open var singleImageLeftOffset: Int {
        get {
            return singleImageLeftOffsetValue
        }
        set {
            singleImageLeftOffsetValue = newValue
        }
    }
    
    @IBInspectable open var singleImageTopOffset: Int {
        get {
            return singleImageTopOffsetValue
        }
        set {
            singleImageTopOffsetValue = newValue
        }
    }
    
    @IBInspectable open var singleLabel: String {
        get {
            return labelOnView
        }
        set {
            var xValue = singleLabelLeftOffsetValue
            if singleLabelHorizontalValue == SingleLabelHorizontal.Left.rawValue {
                xValue = singleLabelLeftOffsetValue
            }
            else if singleLabelHorizontalValue == SingleLabelHorizontal.Right.rawValue {
                xValue = Int(bounds.size.width) - singleLabelWidthValue - singleLabelLeftOffsetValue
            }
            else if singleLabelHorizontalValue == SingleLabelHorizontal.Center.rawValue {
                xValue = (Int(bounds.size.width) - singleLabelWidthValue)/2
            }
            
            var yValue = singleLabelTopOffsetValue
            if singleLabelVerticalValue == SingleLabelVertical.Top.rawValue {
                yValue = singleLabelTopOffsetValue
            }
            else if singleLabelVerticalValue == SingleLabelVertical.Bottom.rawValue {
                yValue = Int(bounds.size.height) - singleLabelHeightValue - singleLabelTopOffsetValue
            }
            else if singleLabelVerticalValue == SingleLabelVertical.Center.rawValue {
                yValue = (Int(bounds.size.height)-Int(singleLabelHeightValue))/2
            }
            
            var xValueImage = singleImageLeftOffsetValue
            if singleImageHorizontalValue == SingleImageHorizontal.Left.rawValue {
                xValueImage = singleImageLeftOffsetValue
            }
            else if singleImageHorizontalValue == SingleImageHorizontal.Right.rawValue {
                xValueImage = Int(bounds.size.width) - singleImageWidthValue - singleImageLeftOffsetValue
            }
            else if singleImageHorizontalValue == SingleImageHorizontal.Center.rawValue {
                xValueImage = (Int(bounds.size.width) - singleImageWidthValue)/2
            }
            
            let lbl = UILabel(frame: CGRect(x: xValue + xValueImage + singleImageWidthValue,
                                            y: yValue,
                                            width: singleLabelWidthValue,
                                            height: singleLabelHeightValue))
            lbl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            setButtonText(btnText: newValue, label: lbl)
            lbl.numberOfLines = 0
            lbl.textAlignment = .left
            self.addSubview(lbl)
            
            labelOnView = newValue
        }
    }
    
    @IBInspectable open var singleLabelH: Int {
        get {
            return singleLabelHorizontalValue
        }
        set {
            singleLabelHorizontalValue = newValue
        }
    }
    
    @IBInspectable open var singleLabelV: Int {
        get {
            return singleLabelVerticalValue
        }
        set {
            singleLabelVerticalValue = newValue
        }
    }
    
    @IBInspectable open var singleLabelWidth: Int {
        get {
            return singleLabelWidthValue
        }
        set {
            singleLabelWidthValue = newValue
        }
    }
    
    @IBInspectable open var singleLabelHeight: Int {
        get {
            return singleLabelHeightValue
        }
        set {
            singleLabelHeightValue = newValue
        }
    }
    
    @IBInspectable open var singleLabelLeftOffset: Int {
        get {
            return singleLabelLeftOffsetValue
        }
        set {
            singleLabelLeftOffsetValue = newValue
        }
    }
    
    @IBInspectable open var singleLabelTopOffset: Int {
        get {
            return singleLabelTopOffsetValue
        }
        set {
            singleLabelTopOffsetValue = newValue
        }
    }
}
