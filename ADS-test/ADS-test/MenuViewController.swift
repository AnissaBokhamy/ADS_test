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
    let blueColor = UIColor(red: 9, green: 83, blue: 254, alpha: 1)
    let textSize: CGFloat = 14
    
    // MARK: - Properties
    weak var delegate: MenuViewControllerDelegate?
    
    private var timestamps: [Date] = []
    
    private var button: UIButton!
    private var textView: UITextView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = blueColor
        configureButton()
        configureTextView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureTextViewLayout()
        configureButtonLayout()
        configureSwipeLeft()
    }
    
    // MARK: - Helpers
    private func configureButton() {
        button = UIButton()
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapAction(sender:)), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func configureButtonLayout() {
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            button.bottomAnchor.constraint(equalTo: textView.topAnchor)
        ])
    }
    
    private func configureTextView() {
        textView = UITextView()
        
        reloadTextView()
        view.addSubview(textView)
    }
    
    private func configureTextViewLayout() {
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: 90),
            textView.widthAnchor.constraint(equalToConstant: 165.5),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureTextView(with timestamps: [Date]) {
        self.timestamps = timestamps
        reloadTextView()
    }
    
    private func reloadTextView() {
        let headerText = "UIScrollView\n\n"
        let timestampLines = timestamps.reversed().compactMap{ "\($0.formatWithDateAndTime())\n" }.joined()
        let text = headerText + timestampLines
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributedText = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: textSize), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let headerTextRange = NSRange(text.range(of: headerText)!, in: text)
        attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: textSize)], range: headerTextRange)

        textView.attributedText = attributedText
    }
    
    private func configureSwipeLeft() {
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeftGestureRecognizer.direction = .left
        view.addGestureRecognizer(swipeLeftGestureRecognizer)
    }
    
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
