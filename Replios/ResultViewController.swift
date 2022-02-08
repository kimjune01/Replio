//
//  ResultViewController.swift
//  Replios
//
//  Created by June Kim on 2/8/22.
//

import UIKit

class ResultViewController: UIViewController {
  var result: String = "" {
    didSet {
      textView.text = result
    }
  }
  let titleLabel = UILabel()
  var textView = UITextView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray4
    addTitleLabel()
    addTextView()
    addDownCaret()
  }
  
  func addTitleLabel() {
    view.addSubview(titleLabel)
    titleLabel.text = "Output:"
    titleLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .semibold)

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
  }
  
  func addTextView() {
    view.addSubview(textView)
    textView.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
    textView.isEditable = false
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
    textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
    
  }
  
  func addDownCaret() {
    var caretConfig = UIButton.Configuration.plain()
    caretConfig.baseForegroundColor = .darkGray
    caretConfig.baseBackgroundColor = .clear
    let caretButton = UIButton(configuration: caretConfig, primaryAction: UIAction(handler: { action in
      self.dismiss(animated: true, completion: nil)
    }))
    caretButton.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal)
    
    view.addSubview(caretButton)
    caretButton.translatesAutoresizingMaskIntoConstraints = false
    caretButton.topAnchor.constraint(equalTo: textView.bottomAnchor).isActive = true
    caretButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
    caretButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    caretButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    caretButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    
  }
}
