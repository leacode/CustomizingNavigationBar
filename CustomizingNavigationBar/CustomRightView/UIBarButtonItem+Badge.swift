//
//  UIBarButtonItem+Badge.swift
//  CustomizingNavigationBar
//
//  Created by leacode on 2017/7/24.
//  Copyright © 2017年 leacode. All rights reserved.
//

import Foundation
import UIKit

private var kBadgeValue = "kBadgeValue"
private var kBadgeColor = "kBadgeColor"
private var kBadgeHeight = "kBadgeHeight"
private var kBadgeBorderWidth = "kBadgeBorderWidth"
private var kBadgeBorderColor = "kBadgeBorderColor"
private var kBadgeFont = "kBadgeFont"
private var kBadgeTextColor = "kBadgeTextColor"
private var kOffsetX = "kOffsetX"
private var kOffsetY = "kOffsetY"

public extension UIBarButtonItem {
  
  public var badgeValue: Int {
    get {
      return (objc_getAssociatedObject(self, &kBadgeValue) as? Int) ?? 0
    }
    set {
      objc_setAssociatedObject(self, &kBadgeValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      
      if newValue <= 0 {
        removeBadge()
        return
      }
      configureBadge()
    }
  }
  
  public var badgeColor: UIColor {
    get {
      return (objc_getAssociatedObject(self, &kBadgeColor) as? UIColor) ?? .red
    }
    set {
      objc_setAssociatedObject(self, &kBadgeColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      configureBadge()
    }
  }
  
  public var badgeHeight: CGFloat {
    get {
      return (objc_getAssociatedObject(self, &kBadgeHeight) as? CGFloat) ?? 16.0
    }
    set {
      objc_setAssociatedObject(self, &kBadgeHeight, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      configureBadge()
    }
  }
  
  public var badgeBorderWidth: CGFloat? {
    get {
      return objc_getAssociatedObject(self, &kBadgeBorderWidth) as? CGFloat
    }
    set {
      objc_setAssociatedObject(self, &kBadgeBorderWidth, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      configureBadge()
    }
  }
  
  public var badgeBorderColor: UIColor? {
    get {
      return objc_getAssociatedObject(self, &kBadgeBorderColor) as? UIColor
    }
    set {
      objc_setAssociatedObject(self, &kBadgeBorderColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      configureBadge()
    }
  }
  
  public var badgeFont: UIFont {
    get {
      return (objc_getAssociatedObject(self, &kBadgeFont) as? UIFont) ?? .systemFont(ofSize: 13.0)
    }
    set {
      objc_setAssociatedObject(self, &kBadgeFont, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      configureBadge()
    }
  }
  
  public var badgeTextColor: UIColor {
    get {
      return (objc_getAssociatedObject(self, &kBadgeTextColor) as? UIColor) ?? .white
    }
    set {
      objc_setAssociatedObject(self, &kBadgeTextColor, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      configureBadge()
    }
  }
  
  public var offsetX: CGFloat {
    get {
      return (objc_getAssociatedObject(self, &kOffsetX) as? CGFloat) ?? 3
    }
    set {
      objc_setAssociatedObject(self, &kOffsetX, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      configureBadge()
    }
  }
  
  public var offsetY: CGFloat {
    get {
      return (objc_getAssociatedObject(self, &kOffsetY) as? CGFloat) ?? 1
    }
    set {
      objc_setAssociatedObject(self, &kOffsetY, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
      configureBadge()
    }
  }
  
  private func removeBadge() {
    
    if let customView = self.customView {
      var badgeLabel: UILabel?
      for subView in customView.subviews {
        if let label = subView as? UILabel,
          (subView as? UILabel)?.tag == 989 {
          badgeLabel = label
        }
      }
      if badgeLabel != nil {
        badgeLabel?.removeFromSuperview()
        badgeLabel = nil
      }
    }
  }
  
  private func configureBadge() {
    if badgeValue <= 0 {
      removeBadge()
      return
    }
  
    if let customView = self.customView {
      var badgeLabel: UILabel?
      for subView in customView.subviews {
        if let label = subView as? UILabel,
          (subView as? UILabel)?.tag == 989 {
          badgeLabel = label
        }
      }
      
      if badgeLabel == nil {
        badgeLabel = UILabel()
        customView.addSubview(badgeLabel!)
      }
      
      badgeLabel!.tag = 989
      badgeLabel!.textColor = badgeTextColor
      badgeLabel!.font = badgeFont
      
      badgeLabel?.backgroundColor = badgeColor
      badgeLabel!.textAlignment = .center
      badgeLabel!.clipsToBounds = true
      
      let text = badgeValue < 100 ? "\(badgeValue)" : "99+"
      badgeLabel?.text = text
      
      let rect = badgeLabel!.sizeThatFits(CGSize(width: 100.0, height: 100.0))
            
      var labelWidth: CGFloat = 0.0
      var labelHeight = rect.height + offsetY * 2
      
      if rect.width <= rect.height {
        labelHeight = max(rect.width, rect.height) + 2
        labelWidth = labelHeight
      } else {
        labelWidth = rect.width + offsetX * 2
      }

      badgeLabel!.frame.size = CGSize(width: labelWidth, height: labelHeight )
      badgeLabel!.layer.cornerRadius = labelHeight * 0.5
      
      if badgeBorderColor != nil {
        badgeLabel?.layer.borderColor = badgeBorderColor?.cgColor
      }

      if badgeBorderWidth != nil {
        badgeLabel?.layer.borderWidth = badgeBorderWidth!
      }
      
      customView.sizeToFit()
      badgeLabel?.frame.origin = CGPoint(x: customView.frame.size.width - labelWidth / 2, y: -rect.height / 2)
    }
  
  }
  
  
}
