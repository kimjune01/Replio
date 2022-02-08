//
//  ViewController.swift
//  Replios
//
//  Created by June Kim on 2/8/22.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    Evaluator.evaluate("x = 'Hello World!'\nprint(x)") { [weak self] result in
      guard let self = self else {
        return
      }
      guard let result = result else {
        print("should show error to user")
        self.view.backgroundColor = .systemYellow
        return
      }
      print(result)
    }
  }
}

