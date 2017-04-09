# LanguageManger-iOS
Language manger used to handle change app language without restart the app

<b>ScreenShots</b>

<img src="https://raw.githubusercontent.com/Abedalkareem/LanguageManger-iOS/master/screen.gif"  width="450">

<b>Usage</b>



```swift
    @IBAction func changeLanguage(_ sender: UIButton) {
        let selectedLanguage = sender.tag == 1 ? "en" : "ar"
        // set the language you need
        LanguageManger.shared.setLanguage(language: selectedLanguage)
        
        // then you must to pop all view controllers and return to root view controller then re set the root view controller 
        UIApplication.topViewController!.dismiss(animated: true) {
            UIApplication.topViewController!.dismiss(animated: true) {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }
```

<b>Installation</b>

Just add ```LanguageManger.swift``` in your project


<b>Note</b>

I'm going to be very happy if you give me a feedback or advice , thank you

<b>License</b>

```
The MIT License (MIT)

Copyright (c) 2014 codestergit

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
