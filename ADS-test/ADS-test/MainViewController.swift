//
//  MainViewController.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 05/05/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var button: UIButton!
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var popUpView: PopUpView!
    
    // MARK: - Constants
    let defaultBlue = CGColor(red: 35, green: 56, blue: 152, alpha: 1)
    let textSize: CGFloat = 12
    
    // MARK: - Properties
    private var timestamps: [Date] = []

    private var menuVC: MenuViewController!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureLayer()
        reloadTextView()
        configureMenuViewController()
        configurePopUpView()
        configureSwipeFromLeft()
    }
    
    // MARK: - Helpers
    private func configureLayer() {
        button.layer.borderColor = defaultBlue
        textView.layer.borderColor = defaultBlue
    }
    
    private func configureMenuViewController() {
        menuVC = MenuViewController()
        menuVC.delegate = self
    }
    
    private func configureMenuViewControllerLayout() {
        NSLayoutConstraint.activate([
            menuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuVC.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: 20)
        ])
    }
    
    private func configurePopUpView() {
        popUpView.delegate = self
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
    
    private func configureSwipeFromLeft() {
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(openMenuAction))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    // MARK: - IBActions
    @IBAction private func buttonTapAction(_ sender: Any) {
        timestamps.append(Date())
        reloadTextView()
        popUpView.configureTextView(with: timestamps)
        menuVC.configureTextView(with: timestamps)
    }
    
    @objc private func openMenuAction() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        navigationController?.present(menuVC, animated: true)
        configureMenuViewControllerLayout()
    }
}

extension MainViewController: PopUpViewDelegate {
    func popUpView(_ view: PopUpView, didTapButton sender: UIButton, atTime timestamp: Date) {
        timestamps.append(timestamp)
        reloadTextView()
    }
}

extension MainViewController: MenuViewControllerDelegate {
    func menuViewController(_ viewController: MenuViewController, didTapButton sender: UIButton, atTime timestamp: Date){
        timestamps.append(timestamp)
        reloadTextView()
    }
    
    func menuViewControllerDidSwipeLeft(_ viewController: MenuViewController) {
        navigationController?.popViewController(animated: true)
    }
}

