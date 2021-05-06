//
//  PopUpView.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 06/05/2021.
//
import UIKit

protocol PopUpViewDelegate: class {
    func popUpView(_ view: PopUpView, didTapButton sender: UIButton)
}

class PopUpView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak private var button: UIButton!
    @IBOutlet weak private var textView: UITextView!
    
    // MARK: - Properties
    weak var delegate: PopUpViewDelegate?
    
    private var timestamps: [Date] = [] {
        didSet {
            reloadTextView()
        }
    }
    
    // MARK: - Helpers
    private func reloadTextView() {
        textView.attributedText = "UIScrollView\n"
    }

    // MARK: - IBActions
    @IBAction private func buttonTapAction(_ sender: UIButton) {
        delegate?.popUpView(self, didTapButton: sender)
    }
}
