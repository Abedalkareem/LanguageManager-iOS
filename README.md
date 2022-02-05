<p align="center">
<img src="https://github.com/Abedalkareem/LanguageManager-iOS/blob/master/Images/logo.png?raw=true"  width="150">  </center>
</p>
<br>

A Language manager to handle changing app language without restarting the app.

<br>


## ScreenShots

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManager-iOS/master/Images/screenrec.gif"  width="450">


## LanguageManager-SwiftUI

For SwiftUI please visit the [LanguageManager-SwiftUI](https://github.com/Abedalkareem/LanguageManager-SwiftUI)

## Usage

<a href="http://www.youtube.com/watch?v=CuZb8nUglcg">Youtube: iOS - Support multiple languages (Localization).</a> <br>
[![Watch the video](http://img.youtube.com/vi/CuZb8nUglcg/0.jpg)](http://www.youtube.com/watch?v=CuZb8nUglcg "iOS - Support multiple languages (Localization).")

First of all, remember to add the ```Localizable.strings``` to your project, after adding the ```Localizable.strings``` file, select it then go to file inspector and below localization press localize, after that go to ```PROJECT > Localisation```  then add the languages you want to support (Arabic for example), dialog will appear to ask you which resource file you want to localize, select just the ```Localizable.strings``` file. <br>  <br>
Now, go to your storyboard and add ```UILable``` and add text to it, for example ```"Hello !"```, then go to your ```Localizable.strings``` file expand it, you will find Localizable strings file for English and Arabic, for English, add this line with the string you used in the ```UILabel``` inside the storyboard   <br>
```"Hello !" = "Hello !";```  <br>
and for Arabic file :  <br>
```"Hello !" = "مرحبا !";```  <br>


<br>
After that in the `didFinishLaunchingWithOptions` method inside the `AppDelegate.swift` file, set your default language that your app will run first time

```swift
LanguageManager.shared.defaultLanguage = .en // you can use .deviceLanguage to keep the device default language.
```

If you want to change the language use the ```setLanguage(language:)``` method by passing to it the new language

```swift
  @IBAction func changeLanguage(_ sender: UIButton) {

    let selectedLanguage: Languages = sender.tag == 1 ? .en : .ar

    // change the language
    LanguageManager.shared.setLanguage(language: selectedLanguage)
    { title -> UIViewController in
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      // the view controller that you want to show after changing the language
      return storyboard.instantiateInitialViewController()!
    } animation: { view in
      // do custom animation
      view.transform = CGAffineTransform(scaleX: 2, y: 2)
      view.alpha = 0
    }
  }
```

If you have an image and you want to change the direction of the image depending on the language, you can use image direction property, the property can be one of the following values:

-`fixed`: if the image must not change the direction depending on the language, you need to set the value as 0.

-`leftToRight`: if the image must change the direction depending on the language
and the image is left to right image then you need to set the value as 1.

-`rightToLeft`: if the image must change the direction depending on the language
and the image is right to left image then you need to set the value as 2.

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManager-iOS/master/Images/ibdesignable.png"  width="450">

Please check the example project to see how it works.

## Installation

LanguageManager-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LanguageManager-iOS'
```

Or you can use [Carthage](https://github.com/Carthage/Carthage).

```
github "Abedalkareem/LanguageManager-iOS"
```

You can also use [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Support me 🚀

You can support this project by:  

1- Checking my [apps](https://apps.apple.com/us/developer/id928910207).  
2- Star the repo.  
3- Share the repo with your friends.  

## Follow me ❤️  

[Facebook](https://www.facebook.com/Abedalkareem.Omreyh/) | [Twitter](https://twitter.com/abedalkareemomr) | [Instagram](https://instagram.com/abedalkareemomreyh/) | [Youtube](https://www.youtube.com/user/AbedalkareemOmreyh)

## License  

Please check the license file.  
