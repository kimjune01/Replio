//
//  WelcomeViewController.swift
//  Replios
//
//  Created by June Kim on 2/8/22.
//

import UIKit

class WelcomeViewController: UIViewController {
  let welcomeView = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white.withAlphaComponent(0.6)
    addWelcomeView()
    addLetsGoButton()
  }
  
  func addWelcomeView() {
    view.addSubview(welcomeView)
    welcomeView.numberOfLines = 0
    welcomeView.text = "Welcome!\n\nReplios is an app that lets you run Python code from your iOS device.\n\nWrite some code, hit run, and see what you get!"
    welcomeView.font = .monospacedSystemFont(ofSize: 16, weight: .medium)

    welcomeView.translatesAutoresizingMaskIntoConstraints = false
    welcomeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant:  -24).isActive = true
    welcomeView.widthAnchor.constraint(equalToConstant: 300).isActive = true
  }
  
  func addLetsGoButton() {
    var buttonConfig = UIButton.Configuration.filled()
    buttonConfig.baseBackgroundColor = .systemBlue
    buttonConfig.buttonSize = .large
    
    let button = UIButton(configuration: buttonConfig, primaryAction: UIAction(handler: { action in
      self.dismiss(animated: true, completion: nil)
    }))
    button.setTitle("Let's go!", for: .normal)
    view.addSubview(button)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    button.topAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: 50).isActive = true
  }
}
