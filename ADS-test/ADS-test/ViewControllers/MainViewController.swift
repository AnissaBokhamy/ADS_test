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
    
    // MARK: - Properties
    private var timestamps: [Date] = []

    private var menuVC: MenuViewController!
    
    var menuVCLeadingConstraint: NSLayoutConstraint!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureLayer()
        button.accessibilityIdentifier = "mainButton"
        textView.accessibilityIdentifier = "mainTextView"
        reloadTextView()
        configureMenuViewController()
        configurePopUpView()
        configureSwipeFromLeft()
    }
    
    // MARK: - Helpers
    private func configureLayer() {
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.borderWidth = 1
    }
    
    private func reloadTextView() {
        textView.attributedText = TextViewHelper.generateAttributedText(for: timestamps)
    }
    
    private func configureSwipeFromLeft() {
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(openMenuAction))
        swipeGestureRecognizerRight.direction = .right
        view.addGestureRecognizer(swipeGestureRecognizerRight)
    }
    
    // MARK: - MenuViewController Helpers
    private func configureMenuViewController() {
        menuVC = MenuViewController()
        menuVC.delegate = self
    }

    private func configureMenuViewControllerLayout() {
        menuVCLeadingConstraint = menuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        NSLayoutConstraint.activate([
            menuVCLeadingConstraint,
            menuVC.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: 20),
            menuVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        menuVC.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - PopUpView Helpers
    private func configurePopUpView() {
        popUpView.delegate = self
    }
    
    // MARK: - Obj-C functions
    @objc private func openMenuAction() {
        view.addSubview(menuVC.view)
        configureMenuViewControllerLayout()
    }
    
    // MARK: - IBActions
    @IBAction private func buttonTapAction(_ sender: Any) {
        timestamps.append(Date())
        reloadTextView()
        popUpView.configureTextView(with: timestamps)
        menuVC.configureTextView(with: timestamps)
    }
}


// MARK: - PopUpViewDelegate
extension MainViewController: PopUpViewDelegate {
    func popUpView(_ view: PopUpView, didTapButton sender: UIButton, atTime timestamp: Date) {
        timestamps.append(timestamp)
        reloadTextView()
        menuVC.configureTextView(with: timestamps)
    }
}

// MARK: - MenuViewControllerDelegate
extension MainViewController: MenuViewControllerDelegate {
    func menuViewController(_ viewController: MenuViewController, didTapButton sender: UIButton, atTime timestamp: Date){
        timestamps.append(timestamp)
        reloadTextView()
        popUpView.configureTextView(with: timestamps)
    }
    
    func menuViewControllerDidSwipeLeft(_ viewController: MenuViewController) {
        let menuVCWidth = self.menuVC.view.frame.width
        self.menuVCLeadingConstraint.constant = -menuVCWidth
        UIView.animate(withDuration: 10, animations: { [weak self] in
            guard let `self` = self else { return }
            self.menuVC.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.menuVC.view.removeFromSuperview()
        })
    }
}

