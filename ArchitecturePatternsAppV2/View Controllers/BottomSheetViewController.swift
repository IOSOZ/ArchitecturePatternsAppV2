//
//  BotomSheetViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.10.2025.
//

import UIKit
import SnapKit

final class BottomSheetViewController: UIViewController {
    
    // MARK: - UI Properties
    private let stackView = UIStackView()
    private let okButton = UIButton(type: .system)
    private var typeButtons: [UIButton] = []
    private let contentView = UIView()
    private let backgroundTapView = UIView()
    
    // MARK: - Properties
    private var selectedType: PatternType?
    var onTypeSelected: ((PatternType) -> Void)?
    weak var delegate: PatternDetailsViewController?
    
    private var heightConstraint: Constraint?
   
    // MARK: - Initialization
    convenience init(selectedType: PatternType? = nil) {
        self.init(nibName: nil, bundle: nil)
        self.selectedType = selectedType
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatePresentation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentViewHeight()
    }
    
    // MARK: - Public Methods
    func getPatternType() -> PatternType {
        return selectedType ?? .behavioral
    }
}

// MARK: - Setup UI
private extension BottomSheetViewController {
    func setupUI() {
        setupBackgroundTapView()
        setupContentView()
        setupStack()
        setupTypeButtons()
        setupOKButton()
        setupConstraints()
        updateOKButtonState()
    }
    
    func setupBackgroundTapView() {
        backgroundTapView.backgroundColor = .clear
        backgroundTapView.isUserInteractionEnabled = true
        view.addSubview(backgroundTapView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        backgroundTapView.addGestureRecognizer(tapGesture)
    }
    
    func setupContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 16
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.transform = CGAffineTransform(translationX: 0, y: 600)
        view.addSubview(contentView)
    }
    
    func setupStack() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        backgroundTapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            self.heightConstraint = make.height.equalTo(300).constraint
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    func updateContentViewHeight() {
        let contentHeight = stackView.systemLayoutSizeFitting(
            CGSize(width: view.bounds.width - 48, height: UIView.layoutFittingCompressedSize.height)
        ).height + 48
        
        let maxHeight = view.bounds.height * 0.8
        let finalHeight = min(contentHeight, maxHeight)
        
        heightConstraint?.update(offset: finalHeight)
        view.layoutIfNeeded()
    }
}

// MARK: - Buttons Setup
private extension BottomSheetViewController {
    func setupTypeButtons() {
        PatternType.allCases.forEach { type in
            let button = createTypeButton(for: type)
            typeButtons.append(button)
            stackView.addArrangedSubview(button)
            
            if type == selectedType {
                updateButtonSelection(button, isSelected: true)
            }
        }
    }
    
    func setupOKButton() {
        okButton.setTitle("ОК", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        okButton.backgroundColor = .systemGray6
        okButton.setTitleColor(.black, for: .normal)
        okButton.layer.cornerRadius = 8
        okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(okButton)
        
        okButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    func createTypeButton(for type: PatternType) -> UIButton {
        let button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = type.rawValue
        configuration.image = UIImage(systemName: "circle.dashed")
        
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)

        configuration.titleAlignment = .trailing
        
        button.configuration = configuration

        button.contentHorizontalAlignment = .fill
        button.titleLabel?.textAlignment = .left
        
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(typeButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
}

// MARK: - Actions & Animations
private extension BottomSheetViewController {
    @objc func typeButtonTapped(_ sender: UIButton) {
        guard let index = typeButtons.firstIndex(of: sender),
              index < PatternType.allCases.count else { return }
        
        let selectedType = PatternType.allCases[index]
        self.selectedType = selectedType
        
        typeButtons.forEach { button in
            let isSelected = (button == sender)
            updateButtonSelection(button, isSelected: isSelected)
        }
        updateOKButtonState()
    }
    
    @objc func okTapped() {
        guard let selectedType = selectedType else { return }
        onTypeSelected?(selectedType)
        delegate?.updatePatternType(selectedType)
        dismissWithAnimation()
    }

    @objc func backgroundTapped() {
        dismissWithAnimation()
    }
    
    func updateButtonSelection(_ button: UIButton, isSelected: Bool) {
        let imageName = isSelected ? "circle.circle.fill" : "circle.dashed"
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.systemGray4.cgColor
        button.backgroundColor = isSelected ? .systemGray5 : .clear
    }
    
    private func updateOKButtonState() {
        let isEnabled = selectedType != nil
        okButton.isEnabled = isEnabled
        okButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    func animatePresentation() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.contentView.transform = .identity
        }
    }
    
    func dismissWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 600)
        }) { _ in
            self.dismiss(animated: false)
        }
    }
}
