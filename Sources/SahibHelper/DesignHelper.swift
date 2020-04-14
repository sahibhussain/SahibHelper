//
//  Design Helper.swift
//  Sahib Helper
//
//  Created by sahib hussain on 05/02/20.
//  Copyright © 2020 sahib hussain. All rights reserved.
//

import UIKit

public class DesignHelper {
    
    public static let shared = DesignHelper()
    public typealias Completion = (_ success: Bool) -> Void
    
    private init () {}
    
//    MARK: -shadow related
    public func dropShadow(_ view: UIView,
                           radius: CGFloat = 6,
                           opacity: Float = 0.16,
                           color: UIColor = .black,
                           offset: CGSize = .init(width: 0, height: 3)) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
    }
    
    
    
    
    
//    MARK: -font awesome related
    public func setButtonFontAwesome(_ btn: UIButton, size: CGFloat, style: FontAwesomeStyle, icon: FontAwesome) {
        btn.titleLabel?.font = UIFont.fontAwesome(ofSize: size, style: style)
        btn.setTitle(String.fontAwesomeIcon(name: icon), for: .normal)
    }
    
    public func setFontAwesomeInFrontAttributedButton(_ btn: UIButton,
                                                      string: String,
                                                      iconColor: UIColor = .black,
                                                      textColor: UIColor = .black,
                                                      size: CGFloat,
                                                      style: FontAwesomeStyle,
                                                      icon: FontAwesome) {
        let attr = [NSAttributedString.Key.foregroundColor: textColor]
        
        let image1Attachment = NSTextAttachment()
        let image = UIImage.fontAwesomeIcon(name: icon, style: style, textColor: iconColor, size: .init(width: size, height: size))
        image1Attachment.image = image
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        let passAttStr = NSMutableAttributedString(string: "")
        passAttStr.append(image1String)
        passAttStr.append(NSAttributedString(string: " \(string)", attributes: attr))
        btn.setAttributedTitle(passAttStr, for: .normal)
    }
    
    public func createImagefromFontAwesome(_ size: CGSize,
                                           style: FontAwesomeStyle,
                                           icon: FontAwesome,
                                           color: UIColor) -> UIImage {
        let img = UIImage.fontAwesomeIcon(name: icon, style: style, textColor: color, size: size)
        return img
    }
    
    
    
    
    
//    MARK: -some extra methods
    public func radioButton(_ button: UIButton, checked: Bool, label: String, color: UIColor = .black) {
        let attr = [NSAttributedString.Key.foregroundColor: color]
        
        let image1Attachment = NSTextAttachment()
        if checked {
            let image = UIImage.fontAwesomeIcon(name: .dotCircle, style: .regular, textColor: color, size: .init(width: 50, height: 50))
            image1Attachment.image = image
        }else {
            let image = UIImage.fontAwesomeIcon(name: .circle, style: .regular, textColor: color, size: .init(width: 50, height: 50))
            image1Attachment.image = image
        }
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        let passAttStr = NSMutableAttributedString(string: "")
        passAttStr.append(image1String)
        passAttStr.append(NSAttributedString(string: " \(label)", attributes: attr))
        button.setAttributedTitle(passAttStr, for: .normal)
    }
    
    public func checkboxButton(_ button: UIButton, checked: Bool, label: String) {
        
    }
    
    public func statusView(viewWidth: CGFloat, color: String) -> UIView {
        let statView = UIView()
        
        if UIDevice.current.hasNotch {
            statView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 44)
            statView.backgroundColor = hexStringToColor(hexStr: color, alpha: 1)
            return statView
        }else {
            statView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: 20)
            statView.backgroundColor = hexStringToColor(hexStr: color, alpha: 1)
            return statView
        }
        
    }
    
    
    
    
//    MARK: -toast related
    public func toast(_ message: String, position: ToastPosition, duration: TimeInterval, view: UIView) {
        
        var style = ToastStyle()
        style.messageAlignment = .center
        
        view.makeToast(message, duration: duration, position: position, style: style)
    }
    
    public func completionToast(_ message: String,
                                position: ToastPosition,
                                duration: TimeInterval,
                                view: UIView,
                                comp: @escaping Completion) {
        var style = ToastStyle()
        style.messageAlignment = .center
        
        view.makeToast(message, duration: duration, position: position, title: nil, image: nil, style: style) { (succ) in
            comp(succ)
        }
        
    }
    
    
    
    
    
    
//    MARK: -imageviewer related
    public func openImageViewer(_ viewController: UIViewController, urls: [String], presentationStyle: UIModalPresentationStyle) {
        let imageVC = ImageViewer(nibName: "ImageViewer", bundle: nil)
        imageVC.imageUrls = urls
        imageVC.modalPresentationStyle = presentationStyle
        viewController.present(imageVC, animated: true, completion: nil)
    }
    
    
    
    
//    MARK: -color related
    public func hexStringToColor(hexStr: String, alpha: CGFloat) -> UIColor {
        var cString: String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}

extension String {
    
    public static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
    
}

extension UITextField {
    
    public func leftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.size.height))
        paddingView.backgroundColor = self.backgroundColor
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    public func rightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: padding, height: self.frame.size.height))
        paddingView.backgroundColor = self.backgroundColor
        
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension UIImage {
    
    public func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let frame = CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage))
        let imageView = UIImageView(frame: frame)
        return resize(imageView)
    }
    
    public func resizeWithWidth(width: CGFloat) -> UIImage? {
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height))))
        let imageView = UIImageView(frame: frame)
        return resize(imageView)
    }
    
    func resize(_ imageView: UIImageView) -> UIImage? {
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
}

extension Bundle {
    
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var bundleIdentifier: String? {
        return infoDictionary?["CFBundleIdentifier"] as? String
    }
    
}

extension UIDevice {
    
    public var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
             return bottom > 0
        } else {
            return false
        }
    }
    
}
