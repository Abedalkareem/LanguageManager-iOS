//
//  LanguageManger.swift
//  aldewanea
//
//  Created by abedalkareem omreyh on 4/5/17.
//  Copyright © 2017 SDVision. All rights reserved.
//

import UIKit

class LanguageManger: Bundle {

    static let shared:LanguageManger = {
        object_setClass(Bundle.main, LanguageManger.self)
        return LanguageManger()
    }()
    
    var currentLang:String{
        get{
            return UserDefaultsHelper.getDataFor(key: "selectedLanguage", defults: NSLocale.preferredLanguages[0])!
        }
        set{
            UserDefaultsHelper.saveDataWith(key: "selectedLanguage", value: newValue)
        }
    }
    
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        
        if let bundle = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Bundle{
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }else{
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
    
    func setLanguage(language:String){
        let value = Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!)
        objc_setAssociatedObject(Bundle.main, &AssociatedObjectHandle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        currentLang = language

        
        NotificationCenter.default.post(name: NSNotification.Name.LanguageDidChange, object: nil)

    }
    

    
    func getLanguageForLocalize() -> String{
        if currentLang == "ar" {
            return "en"
        }else if currentLang == "en" {
            return "ar"
        }else{
            return currentLang
        }
    }
    
    
}


extension NSNotification.Name {
    static var LanguageDidChange:NSNotification.Name{
        return NSNotification.Name.init("languageDidChange")
    }
}
