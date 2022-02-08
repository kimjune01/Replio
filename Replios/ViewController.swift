//
//  ViewController.swift
//  Replios
//
//  Created by June Kim on 2/8/22.
//

import UIKit
import Highlightr

class ViewController: UIViewController {
  
  var codeTextView = UITextView()
  let controlsRow = UIView()
  let spinner = UIActivityIndicatorView()
  let darculaBackground = UIColor(red: 16.0 / 256,
                        green: 16.0 / 256,
                        blue: 21.0 / 256,
                        alpha: 1)

  var addendumHeightConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = darculaBackground
    addCodeTextView()
    addControlsRow()
    addKeyboardAddendum()
    subscribeToKeyboard()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    maybeShowWelcome()
  }
  
  func addCodeTextView() {
    let textStorage = CodeAttributedString()
    textStorage.language = "Python"
    textStorage.highlightr.setTheme(to: "darcula")
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    
    let textContainer = NSTextContainer(size: view.bounds.size)
    layoutManager.addTextContainer(textContainer)
    
    codeTextView = UITextView(frame: view.frame, textContainer: textContainer)
    codeTextView.autocapitalizationType = .none
    codeTextView.autocorrectionType = .no
    codeTextView.keyboardAppearance = .dark
    codeTextView.keyboardType = .asciiCapable
    codeTextView.backgroundColor = darculaBackground
    codeTextView.delegate = self
    codeTextView.text = "print(\"Hello World!\")"
    view.addSubview(codeTextView)
    
    codeTextView.translatesAutoresizingMaskIntoConstraints = false
    codeTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
    codeTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    codeTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    
  }
  
  func addControlsRow() {
    let margin: CGFloat = 12
    view.addSubview(controlsRow)
    controlsRow.backgroundColor = .systemGray

    controlsRow.translatesAutoresizingMaskIntoConstraints = false
    controlsRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    controlsRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    controlsRow.topAnchor.constraint(equalTo: codeTextView.bottomAnchor).isActive = true
    controlsRow.heightAnchor.constraint(equalToConstant: 58).isActive = true
    
    controlsRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedControlsRow)))
    
    var runButtonConfig = UIButton.Configuration.filled()
    runButtonConfig.cornerStyle = UIButton.Configuration.CornerStyle.small
    runButtonConfig.baseBackgroundColor = .systemGreen
    let runButton = UIButton(configuration: runButtonConfig, primaryAction: UIAction(handler: { action in
      self.evaluate()
    }))
    runButton.setTitle("Run", for: .normal)
    controlsRow.addSubview(runButton)
    
    runButton.translatesAutoresizingMaskIntoConstraints = false
    runButton.centerYAnchor.constraint(equalTo: controlsRow.centerYAnchor).isActive = true
    runButton.trailingAnchor.constraint(equalTo: controlsRow.trailingAnchor, constant: -margin).isActive = true
    
    var copyButtonConfig = UIButton.Configuration.filled()
    copyButtonConfig.cornerStyle = UIButton.Configuration.CornerStyle.small
    copyButtonConfig.baseBackgroundColor = .systemOrange
    let copyButton = UIButton(configuration: copyButtonConfig, primaryAction: UIAction(handler: { action in
      guard self.codeTextView.text.count > 0 else { return }
      UIPasteboard.general.string = self.codeTextView.text
      self.showCopyToast()
    }))
    copyButton.setTitle("Copy Code", for: .normal)
    controlsRow.addSubview(copyButton)
    
    copyButton.translatesAutoresizingMaskIntoConstraints = false
    copyButton.centerYAnchor.constraint(equalTo: controlsRow.centerYAnchor).isActive = true
    copyButton.leadingAnchor.constraint(equalTo: controlsRow.leadingAnchor, constant: margin).isActive = true
    
    controlsRow.addSubview(spinner)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.centerXAnchor.constraint(equalTo: controlsRow.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: controlsRow.centerYAnchor).isActive = true
  }
  
  @objc func tappedControlsRow() {
    codeTextView.resignFirstResponder()
  }
  
  func addKeyboardAddendum() {
    let keyboardAddendumRow = UIStackView()
    view.addSubview(keyboardAddendumRow)
    keyboardAddendumRow.axis = .horizontal
    keyboardAddendumRow.alignment = .center
    keyboardAddendumRow.distribution = .fillEqually
    keyboardAddendumRow.spacing = 12
    
    keyboardAddendumRow.translatesAutoresizingMaskIntoConstraints = false
    keyboardAddendumRow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    keyboardAddendumRow.topAnchor.constraint(equalTo: controlsRow.bottomAnchor).isActive = true
    keyboardAddendumRow.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
    addendumHeightConstraint = keyboardAddendumRow.heightAnchor.constraint(equalToConstant: 0)
    addendumHeightConstraint.isActive = true
    
    
    keyboardAddendumRow.addArrangedSubview(makeCharButton("("))
    keyboardAddendumRow.addArrangedSubview(makeCharButton(")"))
    keyboardAddendumRow.addArrangedSubview(makeCharButton("="))
    keyboardAddendumRow.addArrangedSubview(makeCharButton(":"))
    keyboardAddendumRow.addArrangedSubview(makeCharButton("\""))
    keyboardAddendumRow.addArrangedSubview(makeCharButton("+"))
  }
  
  func append(char: String) {
    guard codeTextView.isFirstResponder else {
      return
    }
    codeTextView.text = codeTextView.text + char
  }
  
  func makeCharButton(_ char: String) -> UIButton {
    var charButtonConfig = UIButton.Configuration.filled()
    charButtonConfig.cornerStyle = UIButton.Configuration.CornerStyle.small
    charButtonConfig.baseBackgroundColor = .darkGray
    let charButton = UIButton(configuration: charButtonConfig, primaryAction: UIAction(handler: { action in
      self.append(char:char)
    }))
    
    charButton.setTitle(char, for: .normal)
    return charButton
    
  }
  
  func subscribeToKeyboard() {
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
      UIView.animate(withDuration: 0.3) {
        self.addendumHeightConstraint.constant = 52
      }
    }
    
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
      UIView.animate(withDuration: 0.3) {
        self.addendumHeightConstraint.constant = 0
      }
    }
  }
  
  func showCopyToast() {
    let toast = UIAlertController(title: nil, message: "Copied to clipboard", preferredStyle: .alert)
    present(toast, animated: true) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        toast.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  func evaluate() {
    guard codeTextView.text.count > 0 else { return }
    spinner.startAnimating()
    Evaluator.evaluate(codeTextView.text) { [weak self] result in
      guard let self = self else {
        return
      }
      self.spinner.stopAnimating()
      guard let result = result else {
        print("should show error to user")
        return
      }
      DispatchQueue.main.async {
        self.show(result: result)
      }
    }
  }
  
  func show(result: String) {
    let resultVC = ResultViewController()
    resultVC.result = result
    resultVC.modalPresentationStyle = .formSheet
    
    present(resultVC, animated: true) {
      //
    }
  }
  
  func maybeShowWelcome() {
    defer {
      UserDefaults.standard.set(true, forKey: "Welcome")
    }
//    guard !UserDefaults.standard.bool(forKey: "Welcome") else {
//      return
//    }
    let welcomeVC = WelcomeViewController()
    welcomeVC.modalPresentationStyle = .formSheet
    present(welcomeVC, animated: true, completion: nil)
    
  }
}

extension ViewController: UITextViewDelegate {

}
