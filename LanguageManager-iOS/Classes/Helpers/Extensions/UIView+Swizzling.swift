//
//  UIView+Swizzling.swift
//  LanguageManager-iOS
//
//  Created by abedalkareem omreyh on 10/11/2020.
//

import UIKit

extension UIView {
  static func localize() {

    let orginalSelector = #selector(awakeFromNib)
    let swizzledSelector = #selector(swizzledAwakeFromNib)

    let orginalMethod = class_getInstanceMethod(self, orginalSelector)
    let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

    let didAddMethod = class_addMethod(self, orginalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))

    if didAddMethod {
      class_replaceMethod(self, swizzledSelector, method_getImplementation(orginalMethod!), method_getTypeEncoding(orginalMethod!))
    } else {
      method_exchangeImplementations(orginalMethod!, swizzledMethod!)
    }

  }

  @objc func swizzledAwakeFromNib() {
    swizzledAwakeFromNib()

    switch self {
    case let txtf as UITextField:
      txtf.text = txtf.text?.localiz()
      txtf.placeholder = txtf.placeholder?.localiz()
    case let lbl as UILabel:
      lbl.text = lbl.text?.localiz()
    case let tabbar as UITabBar:
      tabbar.items?.forEach({ $0.title = $0.title?.localiz() })
    case let btn as UIButton:
      btn.setTitle(btn.title(for: .normal)?.localiz(), for: .normal)
    case let sgmnt as UISegmentedControl:
      (0 ..< sgmnt.numberOfSegments).forEach { sgmnt.setTitle(sgmnt.titleForSegment(at: $0)?.localiz(), forSegmentAt: $0) }
    case let txtv as UITextView:
      txtv.text = txtv.text?.localiz()
    default:
      break
    }
  }
}
