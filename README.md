<p align="center">
<img src="https://github.com/Abedalkareem/LanguageManager-iOS/blob/master/thelogo.png?raw=true"  width="150">  </center>
</p>
<br>

Language manager used to handle change app language without restart the app

<br>


## ScreenShots

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManager-iOS/master/screenrec.gif"  width="450">


## LanguageManager-SwiftUI

For SwiftUI please visit the [LanguageManager-SwiftUI](https://github.com/Abedalkareem/LanguageManager-SwiftUI)

## LanguageManager-iOS + Lokalise

For LanguageManger-iOS with Lokalise integration please visit the [LanguageManager-iOS-Lokalise](https://github.com/Abedalkareem/LanguageManager-iOS-Lokalise) repo.

## Usage

<a href="http://www.youtube.com/watch?v=CuZb8nUglcg">Youtube: iOS - Support multiple languages (Localization).</a> <br>
[![Watch the video](http://img.youtube.com/vi/CuZb8nUglcg/0.jpg)](http://www.youtube.com/watch?v=CuZb8nUglcg "iOS - Support multiple languages (Localization).")

First of all, remember to add the ```Localizable.strings``` to your project, after adding the ```Localizable.strings``` file, select it then go to file inspector and below localization press localize, after that go to ```PROJECT > Localisation```  then add the languages you want to support (Arabic for example), dialog will appear to ask you which resource file you want to localize, select just the ```Localizable.strings``` file. <br>  <br>
Now, go to your storyboard and add ```UILable``` and add text to it, for example ```"Hello !"```, then go to your ```Localizable.strings``` file expand it, you will find Localizable strings file for English and Arabic, for English put just this line with the string you put in the ```UILabel``` inside the storyboard   <br>
```"Hello !" = "Hello !";```  <br>
and for Arabic file :  <br>
```"Hello !" = "مرحبا !";```  <br>


<br>
After that in didFinishLaunchingWithOptions inside the AppDelegate.swift set your default language that your app will run first time

```swift
LanguageManager.shared.defaultLanguage = .en // you can use .deviceLanguage to keep the device language.
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

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManager-iOS/master/ibdesignable.png"  width="450">

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

[Facebook](https://www.facebook.com/Abedalkareem.Omreyh/) | [Twitter](http://twitter.com/abedalkareemomr) | [Instagram](http://instagram.com/abedalkareemomreyh/) | [Youtube](https://www.youtube.com/user/AbedalkareemOmreyh)

## License

```
The MIT License (MIT)

Copyright (c) 2017 Abedalkareem

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
