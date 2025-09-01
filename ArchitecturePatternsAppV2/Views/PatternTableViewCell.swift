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
    
    // MARK: - Private Properties
    private var containerView = UIView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var viewCounterLabel = UILabel()
    private var patternImage = UIImageView()
    private var favoriteImage = UIImageView()
    private var arrowLabel = UILabel()
    
    private var nameAndDescriptionStack = UIStackView()
    private var upperHorizontalStack = UIStackView()
    private var bottomHorizontalStack = UIStackView()
    private var generalCellStack = UIStackView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpStacks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints SetUp
    func setUpConstaints(with indexPath: IndexPath) {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        viewCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        patternImage.translatesAutoresizingMaskIntoConstraints = false
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndDescriptionStack.translatesAutoresizingMaskIntoConstraints = false
        upperHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        bottomHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        generalCellStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        patternImage.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        
        favoriteImage.snp.makeConstraints { make in
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
            make.top.equalToSuperview().offset(indexPath.row == 0 ? 0 : 16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Stacks SetUp
    private func setUpStacks() {
        nameAndDescriptionStack.axis = .vertical
        nameAndDescriptionStack.addArrangedSubview(nameLabel)
        nameAndDescriptionStack.addArrangedSubview(descriptionLabel)
        nameAndDescriptionStack.alignment = .leading
        nameAndDescriptionStack.spacing = 0
        nameAndDescriptionStack.distribution = .fill
        nameAndDescriptionStack.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        upperHorizontalStack.axis = .horizontal
        upperHorizontalStack.addArrangedSubview(patternImage)
        upperHorizontalStack.addArrangedSubview(nameAndDescriptionStack)
        upperHorizontalStack.addArrangedSubview(arrowLabel)
        upperHorizontalStack.spacing = 8
        upperHorizontalStack.alignment = .center
        
        
        bottomHorizontalStack.axis = .horizontal
        bottomHorizontalStack.addArrangedSubview(viewCounterLabel)
        bottomHorizontalStack.addArrangedSubview(favoriteImage)
        bottomHorizontalStack.distribution = .fill
        
        generalCellStack.axis = .vertical
        generalCellStack.addArrangedSubview(upperHorizontalStack)
        generalCellStack.addArrangedSubview(bottomHorizontalStack)
        
        containerView.addSubview(generalCellStack)
        contentView.addSubview(containerView)
    }
    
    // MARK: - UI SetUP
    func setupUI(with patternModel: Pattern) {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.backgroundColor = .white
        containerView.layer.borderColor = CGColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 100)
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        let nameLabelStyle = NSMutableParagraphStyle()
        nameLabelStyle.minimumLineHeight = 24
        let nameLabelAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "SFPro-Semibold", size: 13) ?? .systemFont(ofSize: 13, weight: .semibold),
            .paragraphStyle: nameLabelStyle
        ]
        nameLabel.attributedText = NSAttributedString(string: "\(patternModel.name)", attributes: nameLabelAttributes)
        
        descriptionLabel.numberOfLines = 2
        let descriptionLabelStyle = NSMutableParagraphStyle()
        descriptionLabelStyle.minimumLineHeight = 24
        descriptionLabelStyle.lineBreakMode = .byTruncatingTail
        let descriptionLabelAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "SFPro-Regular", size: 13) ?? .systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: UIColor(named: "labelSecondary") ?? .gray,
            .paragraphStyle: descriptionLabelStyle
        ]
        descriptionLabel.attributedText = NSAttributedString(string: "\(patternModel.description)", attributes: descriptionLabelAttributes)
        
        let viewCounterLabelStyle = NSMutableParagraphStyle()
        let viewCounterLabelAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "SFPro-Regular", size: 8) ?? .systemFont(ofSize: 8, weight: .regular),
            .foregroundColor: UIColor(white: 0, alpha: 0.52),
            .paragraphStyle: viewCounterLabelStyle
        ]
        viewCounterLabel.attributedText = NSAttributedString(string: "Посмотрено раз: \(patternModel.viewCounter)", attributes: viewCounterLabelAttributes)
        
        let arrowLabelStyle = NSMutableParagraphStyle()
        arrowLabelStyle.minimumLineHeight = 22
        arrowLabelStyle.alignment = .center
        let arrowLabelAttibutes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "SFPro-Semibold", size: 17) ?? .systemFont(ofSize: 17, weight: .regular),
            .foregroundColor: UIColor(named: "labelTertiary") ?? .gray,
            .paragraphStyle: arrowLabelStyle
        ]
        arrowLabel.attributedText = NSAttributedString(string: "􀆊", attributes: arrowLabelAttibutes)
        
        patternImage.image = UIImage(named: patternModel.image)
        favoriteImage.image = {
            patternModel.isFavorite == false ? UIImage(named: "notLike") : UIImage(named: "like")
        }()
    }
    
    // MARK: - Private Methods
    private func isFirstCellInSection() -> Bool {
        guard let tableView = self.superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else { return false }
        return indexPath.row == 0
    }
}

