//
//  MenuViewController.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 08/05/2021.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuViewController(_ viewController: MenuViewController, didTapButton sender: UIButton, atTime timestamp: Date)
    func menuViewControllerDidSwipeLeft(_ viewController: MenuViewController)
}

class MenuViewController: UIViewController {
    
    // MARK: - Constants
    let blueColor = UIColor(red: 1/255, green: 110/255, blue: 255/255, alpha: 0.7)
    
    // MARK: - Properties
    weak var delegate: MenuViewControllerDelegate?
    
    private var timestamps: [Date] = []
    
    private var button = UIButton()
    private var textView = UITextView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = blueColor
        configureButton()
        configureTextView()
        configureSwipeLeft()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureButtonLayout()
        configureTextViewLayout()
    }
    
    // MARK: - Helpers
    func configureTextView(with timestamps: [Date]) {
        self.timestamps = timestamps
        reloadTextView()
    }
    
    private func reloadTextView() {
        textView.attributedText = TextViewHelper.generateAttributedText(for: timestamps)
    }
    
    private func configureSwipeLeft() {
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeftGestureRecognizer.direction = .left
        view.addGestureRecognizer(swipeLeftGestureRecognizer)
    }
    
    // MARK: - Button configurations
    private func configureButton() {
        button = UIButton()
        button.accessibilityIdentifier = "menuButton"
        
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentMode = .center
        button.setTitle("Button", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(buttonTapAction(sender:)), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func configureButtonLayout() {
        button.sizeToFit()
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: textView.topAnchor)
        ])
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - TextView configurations
    private func configureTextView() {
        textView = UITextView()
        textView.accessibilityIdentifier = "menuTextView"
        
        textView.backgroundColor = .clear
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.borderWidth = 1
        reloadTextView()

        view.addSubview(textView)
    }
    
    private func configureTextViewLayout() {
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 100),
            textView.topAnchor.constraint(equalTo: button.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Obj-C functions
    @objc private func swipeLeftAction() {
        delegate?.menuViewControllerDidSwipeLeft(self)
    }
    
    @objc func buttonTapAction(sender: UIButton) {
        let timestamp = Date()
        timestamps.append(timestamp)
        reloadTextView()

        delegate?.menuViewController(self, didTapButton: sender, atTime: timestamp)
    }
}
