//
//  LanguageManager.swift
//
//  Created by abedalkareem omreyh on 10/23/17.
//  Copyright © 2017 abedlkareem omreyh. All rights reserved.
//  GitHub: https://github.com/Abedalkareem/LanguageManager-iOS
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Abedalkareem
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public class LanguageManager {

  /// Returns the singleton LanguageManager instance.
  public static let shared: LanguageManager = LanguageManager()

  /// Returns the currnet language
  public var currentLanguage: Languages {
    get {
      guard let currentLang = UserDefaults.standard.string(forKey: Constants.defaultsKeys.selectedLanguage) else {
        fatalError("Did you set the default language for the app ?")
      }
      return Languages(rawValue: currentLang)!
    }
    set {
      UserDefaults.standard.set(newValue.rawValue, forKey: Constants.defaultsKeys.selectedLanguage)
    }
  }

  /// Returns the default language that the app will run first time
  public var defaultLanguage: Languages {
    get {

      guard let defaultLanguage = UserDefaults.standard.string(forKey: Constants.defaultsKeys.defaultLanguage) else {
        fatalError("Did you set the default language for the app ?")
      }
      return Languages(rawValue: defaultLanguage)!
    }
    set {

      // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
      UIView.localize()

      let defaultLanguage = UserDefaults.standard.string(forKey: Constants.defaultsKeys.defaultLanguage)
      guard defaultLanguage == nil else {
        setLanguage(language: currentLanguage)
        return
      }

      UserDefaults.standard.set(newValue.rawValue, forKey: Constants.defaultsKeys.defaultLanguage)
      UserDefaults.standard.set(newValue.rawValue, forKey: Constants.defaultsKeys.selectedLanguage)
      setLanguage(language: newValue)
    }
  }

  /// Returns the diriction of the language
  public var isRightToLeft: Bool {
    get {
      return isLanguageRightToLeft(language: currentLanguage)
    }
  }

  /// Returns the app locale for use it in dates and currency
  public var appLocale: Locale {
    get {
      return Locale(identifier: currentLanguage.rawValue)
    }
  }

  ///
  /// Set the current language for the app
  ///
  /// - parameter language: The language that you need from the app to run with.
  /// - parameter rootViewController: The new view controller to show after changing the language.
  /// - parameter animation: A closure with the current view to animate to the new view controller,
  ///                        so you need to animate the view, move it out of the screen, change the alpha,
  ///                        or scale it down to zero.
  ///
  public func setLanguage(language: Languages, rootViewController: UIViewController? = nil, animation: ((UIView) -> Void)? = nil) {

    // change the dircation of the views
    let semanticContentAttribute: UISemanticContentAttribute = isLanguageRightToLeft(language: language) ? .forceRightToLeft : .forceLeftToRight
    UIView.appearance().semanticContentAttribute = semanticContentAttribute

    // set current language
    currentLanguage = language

    guard let rootViewController = rootViewController else {
      return
    }

    let snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
    rootViewController.view.addSubview(snapshot);

    UIApplication.shared.delegate?.window??.rootViewController = rootViewController

    UIView.animate(withDuration: 0.5, animations: {
      animation?(snapshot)
    }) { _ in
      snapshot.removeFromSuperview()
    }

  }

  private func isLanguageRightToLeft(language: Languages) -> Bool {
    return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
  }

}

// MARK: - Languages

public enum Languages: String {
  case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,
       ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he,ur,fa,ku,arc,sl
  case enGB = "en-GB"
  case enAU = "en-AU"
  case enCA = "en-CA"
  case enIN = "en-IN"
  case frCA = "fr-CA"
  case esMX = "es-MX"
  case ptBR = "pt-BR"
  case zhHans = "zh-Hans"
  case zhHant = "zh-Hant"
  case zhHK = "zh-HK"
}

// MARK: - Swizzling

fileprivate extension UIView {
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

// MARK: - String extension

public extension String {

  ///
  /// Localize the current string to the selected language
  ///
  /// - returns: The localized string
  ///
  func localiz(comment: String = "") -> String {
    guard let bundle = Bundle.main.path(forResource: LanguageManager.shared.currentLanguage.rawValue, ofType: "lproj") else {
      return NSLocalizedString(self, comment: comment)
    }

    let langBundle = Bundle(path: bundle)
    return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
  }

}


// MARK: - ImageDirection

public enum ImageDirection: Int {
  case fixed, leftToRight, rightToLeft
}

private extension UIView {
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
  var direction: ImageDirection {
    set {
      switch newValue {
      case .fixed:
        break
      case .leftToRight where LanguageManager.shared.isRightToLeft:
        transform = CGAffineTransform(scaleX: -1, y: 1)
      case .rightToLeft where !LanguageManager.shared.isRightToLeft:
        transform = CGAffineTransform(scaleX: -1, y: 1)
      default:
        break
      }
    }
    get {
      fatalError("There is no value return from this variable, this variable used to change the image direction depending on the langauge")
    }
  }
}

@IBDesignable
public extension UIImageView {
  @IBInspectable var imageDirection: Int {
    set {
      direction = ImageDirection(rawValue: newValue)!
    }
    get {
      return direction.rawValue
    }
  }
}

@IBDesignable
public extension UIButton {
  @IBInspectable var imageDirection: Int {
    set {
      direction = ImageDirection(rawValue: newValue)!
    }
    get {
      return direction.rawValue
    }
  }
}


// MARK: - Constants

fileprivate enum Constants {

  enum defaultsKeys {
    static let selectedLanguage = "LanguageManagerSelectedLanguage"
    static let defaultLanguage = "LanguageManagerDefaultLanguage"
  }

  enum strings {
    static let unlocalized = "<unlocalized>"
  }
}
