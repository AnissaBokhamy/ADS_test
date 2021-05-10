//
//  PopUpView.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 06/05/2021.
//
import UIKit

protocol PopUpViewDelegate: class {
    func popUpView(_ view: PopUpView, didTapButton sender: UIButton, atTime timestamp: Date)
}

class PopUpView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var button: UIButton!
    @IBOutlet weak private var textView: UITextView!
    
    // MARK: - Constants
    let nibName = "PopUpXib"
    
    // MARK: - Properties
    weak var delegate: PopUpViewDelegate?

    private var timestamps: [Date] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        configureLayer()
        reloadTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
        configureLayer()
        button.accessibilityIdentifier = "popupButton"
        textView.accessibilityIdentifier = "popupTextView"
        reloadTextView()
    }
    
    // MARK: - Nib Helpers
    private func setupView() {
        guard let nibView = loadViewFromNib() else { return }
        contentView = nibView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
                nibView.frame = bounds
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // MARK: - Helpers
    private func configureLayer() {
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.borderWidth = 1
    }

    func configureTextView(with timestamps: [Date]) {
        self.timestamps = timestamps
        reloadTextView()
    }
    
    private func reloadTextView() {
        textView.attributedText = TextViewHelper.generateAttributedText(for: timestamps)
    }

    // MARK: - IBActions
    @IBAction private func buttonTapAction(_ sender: UIButton) {
        let timestamp = Date()
        timestamps.append(timestamp)
        reloadTextView()

        delegate?.popUpView(self, didTapButton: sender, atTime: timestamp)
    }
}
