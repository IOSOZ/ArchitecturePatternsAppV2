//
//  PatternTableViewCell.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit

final class PatternTableViewCell: UITableViewCell {
    // MARK: - Public Properties
    static var identifier: String {
        String(describing: Self.self)
    }
    
    // MARK: - UI Properties
    private var containerView = UIView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var viewCounterLabel = UILabel()
    private var patternImage = UIImageView()
    private var favoriteButton = UIButton()
    private var arrowLabel = UILabel()
    
    private var nameAndDescriptionStack = UIStackView()
    private var upperHorizontalStack = UIStackView()
    private var bottomHorizontalStack = UIStackView()
    private var generalCellStack = UIStackView()
    
    private var object: Pattern!
    
    // MARK: - Properties
    enum UIElement {
        case nameLabel
        case descriptionLabel
        case viewCounterLabel
        case arrowLabel
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI SetUP
    func configure(with patternModel: Pattern, isFirstCell: Bool) {
        self.object = patternModel
        
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = .white
        containerView.layer.borderColor = CGColor(
            red: 227/255,
            green: 227/255,
            blue: 227/255,
            alpha: 100
        )
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        nameLabel.attributedText = NSAttributedString(string: "\(patternModel.name)", attributes: getAttributesFor(.nameLabel))
        descriptionLabel.attributedText = NSAttributedString(string: "\(patternModel.description)", attributes: getAttributesFor(.descriptionLabel))
        viewCounterLabel.attributedText = NSAttributedString(string: "Посмотрено раз: \(patternModel.viewCounter)", attributes: getAttributesFor(.viewCounterLabel))
        arrowLabel.attributedText = NSAttributedString(string: "􀆊", attributes: getAttributesFor(.arrowLabel))
        
        descriptionLabel.numberOfLines = 2
        patternImage.image = patternModel.image
        
        favoriteButton.setImage(
            patternModel.isFavorite == false ? UIImage(named: "notLike") : UIImage(named: "like"),
            for: .normal
        )
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        
        containerView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(isFirstCell ? 0 : 16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - objc methods
    @objc func didTapFavoriteButton() {
        object.isFavorite.toggle()
        StorageManager.shared.updatePattern(object!)
        
        UIView.animate(withDuration: 0.3) {
            switch self.object!.isFavorite {
            case true:
                self.favoriteButton.setImage(UIImage(resource: .like), for: .normal)
            default:
                self.favoriteButton.setImage(UIImage(resource: .notLike), for: .normal)
            }
        }
    }
}

// MARK: - Extension PatternTableViewCell
private extension PatternTableViewCell {
    
    // MARK: - SetUP View
    func setupView() {
        addViews()
        setUpStacks()
        setupConstraints()
    }
    
    // MARK: - Stacks SetUp
    func setUpStacks() {
        nameAndDescriptionStack.axis = .vertical
        nameAndDescriptionStack.alignment = .leading
        nameAndDescriptionStack.spacing = 0
        nameAndDescriptionStack.distribution = .fill
        nameAndDescriptionStack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        upperHorizontalStack.axis = .horizontal
        upperHorizontalStack.spacing = 8
        upperHorizontalStack.alignment = .center
        
        bottomHorizontalStack.axis = .horizontal
        bottomHorizontalStack.distribution = .fill
        
        generalCellStack.axis = .vertical
    }
    
    // MARK: - Add Views
    func addViews() {
        nameAndDescriptionStack.addArrangedSubview(nameLabel)
        nameAndDescriptionStack.addArrangedSubview(descriptionLabel)
        
        upperHorizontalStack.addArrangedSubview(patternImage)
        upperHorizontalStack.addArrangedSubview(nameAndDescriptionStack)
        upperHorizontalStack.addArrangedSubview(arrowLabel)
        
        bottomHorizontalStack.addArrangedSubview(viewCounterLabel)
        bottomHorizontalStack.addArrangedSubview(favoriteButton)
        
        generalCellStack.addArrangedSubview(upperHorizontalStack)
        generalCellStack.addArrangedSubview(bottomHorizontalStack)
        
        containerView.addSubview(generalCellStack)
        contentView.addSubview(containerView)
    }
    
    // MARK: - Constraints SetUp
    func setupConstraints() {
        
        patternImage.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        nameAndDescriptionStack.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(4)
        }
        
        arrowLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        generalCellStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(4)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Get Attributes For UI Element
    func getAttributesFor(_ element: UIElement) -> [NSAttributedString.Key : Any] {
        
        switch element {
        case . nameLabel:
            let nameLabelStyle = NSMutableParagraphStyle()
            nameLabelStyle.minimumLineHeight = 24
            return [
                .font: UIFont(name: "SFPro-Semibold", size: 13) ?? .systemFont(ofSize: 13, weight: .semibold),
                .paragraphStyle: nameLabelStyle
            ]
        case . descriptionLabel:
            let descriptionLabelStyle = NSMutableParagraphStyle()
            descriptionLabelStyle.minimumLineHeight = 24
            descriptionLabelStyle.lineBreakMode = .byTruncatingTail
            return [
                .font: UIFont(name: "SFPro-Regular", size: 13) ?? .systemFont(ofSize: 13, weight: .regular),
                .foregroundColor: UIColor(named: "labelSecondary") ?? .gray,
                .paragraphStyle: descriptionLabelStyle
            ]
        case .viewCounterLabel:
            let viewCounterLabelStyle = NSMutableParagraphStyle()
            return [
                .font: UIFont(name: "SFPro-Regular", size: 8) ?? .systemFont(ofSize: 8, weight: .regular),
                .foregroundColor: UIColor(white: 0, alpha: 0.52),
                .paragraphStyle: viewCounterLabelStyle
            ]
        case .arrowLabel:
            let arrowLabelStyle = NSMutableParagraphStyle()
            arrowLabelStyle.minimumLineHeight = 22
            arrowLabelStyle.alignment = .center
            return [
                .font: UIFont(name: "SFPro-Semibold", size: 17) ?? .systemFont(ofSize: 17, weight: .regular),
                .foregroundColor: UIColor(named: "labelTertiary") ?? .gray,
                .paragraphStyle: arrowLabelStyle
            ]
        }
    }
}
