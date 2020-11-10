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

  public typealias Animation = ((UIView) -> Void)
  public typealias ViewControllerFactory = ((String?) -> UIViewController)
  public typealias WindowAndTitle = (UIWindow?, String?)

  // MARK: - Private properties

  private var storage = Storage()

  // MARK: - Properties

  ///
  /// The singleton LanguageManager instance.
  ///
  public static let shared: LanguageManager = LanguageManager()

  ///
  /// Current app language.
  /// *Note, This property just to get the current lanuage,
  /// To set the language use:
  /// `setLanguage(language:, for:, viewControllerFactory:, animation:)`*
  ///
  public private(set) var currentLanguage: Languages {
    get {
      guard let currentLang = storage.string(forKey: .selectedLanguage) else {
        fatalError("Did you set the default language for the app?")
      }
      return Languages(rawValue: currentLang)!
    }
    set {
      storage.set(newValue.rawValue, forKey: .selectedLanguage)
    }
  }

  ///
  /// The default language that the app will run first time.
  /// You need to set the `defaultLanguage` in the `AppDelegate`, specifically in
  /// the first line inside `application(_:willFinishLaunchingWithOptions:)`.
  ///
  public var defaultLanguage: Languages {
    get {
      guard let defaultLanguage = storage.string(forKey: .defaultLanguage) else {
        fatalError("Did you set the default language for the app?")
      }
      return Languages(rawValue: defaultLanguage)!
    }
    set {
      // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
      UIView.localize()

      let defaultLanguage = storage.string(forKey: .defaultLanguage)
      guard defaultLanguage == nil else {
        // If the default language has been set before,
        // that means that the user opened the app before and maybe
        // he changed the language so here the `currentLanguage` is being set.
        setLanguage(language: currentLanguage)
        return
      }

      var language = newValue
      if language == .deviceLanguage {
        language = deviceLanguage ?? .en
      }

      storage.set(language.rawValue, forKey: .defaultLanguage)
      storage.set(language.rawValue, forKey: .selectedLanguage)
      setLanguage(language: language)
    }
  }

  ///
  /// The device language is deffrent than the app language,
  /// to get the app language use `currentLanguage`.
  ///
  public var deviceLanguage: Languages? {
    get {
      guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
        return nil
      }
      return Languages(rawValue: deviceLanguage)
    }
  }

  /// The diriction of the language.
  public var isRightToLeft: Bool {
    get {
      return isLanguageRightToLeft(language: currentLanguage)
    }
  }

  /// The app locale to use it in dates and currency.
  public var appLocale: Locale {
    get {
      return Locale(identifier: currentLanguage.rawValue)
    }
  }

  // MARK: - Public Methods

  ///
  /// Set the current language of the app
  ///
  /// - parameter language: The language that you need the app to run with.
  /// - parameter windows: The windows you want to change the `rootViewController` for. if you didn't
  ///                      set it, it will change the `rootViewController` for all the windows in the
  ///                      scenes.
  /// - parameter viewControllerFactory: A closure to make the `ViewController` for a specific `scene`, you can know for which
  ///                                    `scene` you need to make the controller you can check the `title` sent to this clouser,
  ///                                    this title is the `title` of the `scene`, so if there is 5 scenes this closure will get called 5 times
  ///                                    for each scene window.
  /// - parameter animation: A closure with the current view to animate to the new view controller,
  ///                        so you need to animate the view, move it out of the screen, change the alpha,
  ///                        or scale it down to zero.
  ///
  public func setLanguage(language: Languages,
                          for windows: [WindowAndTitle]? = nil,
                          viewControllerFactory: ViewControllerFactory? = nil,
                          animation: Animation? = nil) {

    changeCurrentLanguageTo(language)

    guard let viewControllerFactory = viewControllerFactory else {
      return
    }

    let windowsToChange = getWindowsToChangeFrom(windows)

    windowsToChange?.forEach({ windowAndTitle in
      let (window, title) = windowAndTitle
      let viewController = viewControllerFactory(title)
      changeViewController(for: window,
                           rootViewController: viewController,
                           animation: animation)
    })

  }

  // MARK: - Private Methods

  private func changeCurrentLanguageTo(_ language: Languages) {
    // change the dircation of the views
    let semanticContentAttribute: UISemanticContentAttribute = isLanguageRightToLeft(language: language) ? .forceRightToLeft : .forceLeftToRight
    UIView.appearance().semanticContentAttribute = semanticContentAttribute

    // set current language
    currentLanguage = language
  }

  private func getWindowsToChangeFrom(_ windows: [WindowAndTitle]?) -> [WindowAndTitle]? {
    var windowsToChange: [WindowAndTitle]?
    if let windows = windows {
      windowsToChange = windows
    } else {
      if #available(iOS 13.0, *) {
        windowsToChange = UIApplication.shared.connectedScenes
          .compactMap({$0 as? UIWindowScene})
          .map({ ($0.windows.first, $0.title) })
      } else {
        windowsToChange = [(UIApplication.shared.keyWindow, nil)]
      }
    }

    return windowsToChange
  }

  private func changeViewController(for window: UIWindow?,
                                    rootViewController: UIViewController,
                                    animation: Animation? = nil) {
    guard let snapshot = window?.snapshotView(afterScreenUpdates: true) else {
      return
    }
    rootViewController.view.addSubview(snapshot);

    window?.rootViewController = rootViewController

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
