//
//  UIImageView+Direction.swift
//  LanguageManager-iOS
//
//  Created by abedalkareem omreyh on 10/11/2020.
//

import UIKit

@IBDesignable
public extension UIImageView {
  ///
  /// Change the direction of the image depeneding in the language, there is no return value for this variable.
  /// The expectid values:
  ///
  /// -`fixed`: if the image must not change the direction depending on the language you need to set the value as 0.
  ///
  /// -`leftToRight`: if the image must change the direction depending on the language
  /// and the image is left to right image then you need to set the value as 1.
  ///
  /// -`rightToLeft`: if the image must change the direction depending on the language
  /// and the image is right to left image then you need to set the value as 2.
  ///
  @IBInspectable var imageDirection: Int {
    set {
      direction = ViewDirection(rawValue: newValue)!
    }
    get {
      return direction.rawValue
    }
  }
}
