//
//  ViewController.swift
//  LanguageManager-iOS
//
//  Created by Abedalkareem on 08/09/2018.
//  Copyright (c) 2018 Abedalkareem. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
      self.performSegue(withIdentifier: "nextPage", sender: self)
    }
  }
  
}

