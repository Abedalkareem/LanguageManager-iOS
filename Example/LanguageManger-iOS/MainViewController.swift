//
//  MainViewController.swift
//  LanguageManager
//
//  Created by abedalkareem omreyh on 4/9/17.
//  Copyright © 2017 abedalkareem. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class MainViewController: UIViewController {

    
    @IBOutlet weak var lblTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hello !!".localiz()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.locale = LanguageManager.shared.appLocale
        
        let month = dateFormatter.string(from: date)
        lblTest.text = month
        
    }


}
