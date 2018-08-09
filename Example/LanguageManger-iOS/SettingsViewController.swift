//
//  SettingsViewController.swift
//  LanguageManager
//
//  Created by abedalkareem omreyh on 4/9/17.
//  Copyright © 2017 abedalkareem. All rights reserved.
//

import UIKit
import LanguageManger_iOS

class SettingsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func changeLanguage(_ sender: UIButton) {
        
        let selectedLanguage: Languages = sender.tag == 1 ? .en : .ar
        
        // change the language
        LanguageManger.shared.setLanguage(language: selectedLanguage)

        // return to root view contoller and reload it
        UIApplication.topViewController!.dismiss(animated: true) {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            delegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
    }
    

}
