//
//  PatternTableViewCell.swift
//  ArchitecturePatternsApp
//
//  Created by Олег Зуев on 25.08.2025.
//

import UIKit
import SnapKit
#warning("разделяй марками")

class PatternTableViewCell: UITableViewCell {

#warning("на созвоне покажу как лучше будет создавать идентификатор")
    static let identifier = "PatternCell"
    
#warning("на созвоне обсудим эти правила создания юай компонентов")
#warning("нуууу не соовтетствует конечно дизайну")

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    var viewCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        return label
    }()
    
    var patternImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        return image
    }()
    
    var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
#warning("тут ты использовал один архитектурный подход, а на контроллере другой. не вариант")

        image.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
        
        return image
    }()
    
    var arrowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
#warning("а ниже третий способ использовал")

    var yStack = UIStackView()
    var xStackTop = UIStackView()
    var xStackLow = UIStackView()
    var fullStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpStacks()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
#warning("ну и нейминги конечно получше выбирать надо")

    private func setUpStacks() {
        yStack.axis = .vertical
        yStack.addArrangedSubview(nameLabel)
        yStack.addArrangedSubview(descriptionLabel)
        yStack.alignment = .leading
        
        xStackTop.axis = .horizontal
        xStackTop.addArrangedSubview(patternImage)
        xStackTop.addArrangedSubview(yStack)
        xStackTop.addArrangedSubview(arrowLabel)
        xStackTop.spacing = 8
        xStackTop.distribution = .fill
        
        xStackLow.axis = .horizontal
        xStackLow.addArrangedSubview(viewCounterLabel)
        xStackLow.addArrangedSubview(favoriteImage)
        xStackLow.distribution = .fill
        
        fullStack.axis = .vertical
        fullStack.addArrangedSubview(xStackTop)
        fullStack.addArrangedSubview(xStackLow)
        fullStack.spacing = 8
        
        
        
    }
#warning("а почему тут констрейнты не выделли отедльно?")

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        containerView.addSubview(fullStack)
        
        fullStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            }
        
        contentView.addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            }
        }
}
