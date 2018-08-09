<p align="center">
<img src="https://github.com/Abedalkareem/LanguageManger-iOS/blob/master/logo.png?raw=true"  width="150">  </center>
</p>
<br>

Language manager used to handle change app language without restart the app

<br>


<b>ScreenShots</b>

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManger-iOS/master/screenrec.gif"  width="450">

<b>Usage</b>

First of all remember to add the ```Localizable.strings``` to your project, after adding the ```Localizable.strings``` file, select it then go to file inspector and below localization press localize, after that go to ```PROJECT > Localisation```  then add the languages you want to support (Arabic for example), dialog will appear to ask you which resource file you want to localize, select just the ```Localizable.strings``` file. <br>  <br>
Now, go to your storyboard and add ```UILable``` and add text to it, for example ```"Hello !"```, then go to your ```Localizable.strings``` file expand it, you will find Localizable strings file for English and Arabic, for English put just this line with the string you put in the ```UILabel``` inside the storyboard   <br>
```"Hello !" = "Hello !";```  <br>
and for Arabic file :  <br>
```"Hello !" = "مرحبا !";```  <br>


<br>
After that in didFinishLaunchingWithOptions inside the AppDelegate.swift set your default language that your app will run first time

```swift
LanguageManger.shared.defaultLanguage = .en
```

If you want to change the language use the ```setLanguage(language:)``` method by passing to it the new language

```swift
@IBAction func changeLanguage(_ sender: UIButton) {

let selectedLanguage:Languages = sender.tag == 1 ? .en : .ar

// change the language
LanguageManger.shared.setLanguage(language: selectedLanguage)

// then you must to pop all view controllers and return to root view controller then re set the root view controller 
UIApplication.topViewController!.dismiss(animated: true) {
let delegate = UIApplication.shared.delegate as! AppDelegate
let storyboard = UIStoryboard(name: "Main", bundle: nil)
delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
}
}
```

*Note <br>
The language manager help you to support multiple languages in your app, However, there are some cases that you want to handle it yourself like some ```UILable``` or ```UITextField``` didn't change the direction, so you need to do that .
Example:

``` textAlignment =  LanguageManger.shared.isRightToLeft ? .right : .left. ```

<b>Installation</b>

Just add ```LanguageManger.swift``` in your project


<b>Note</b>

I'm going to be very happy if you give me a feedback or advice , thank you


<b>License</b>

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
