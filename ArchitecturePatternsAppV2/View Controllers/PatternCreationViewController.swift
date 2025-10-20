//
//  PatternCreationViewController.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 14.10.2025.
//

import UIKit
import PhotosUI

final class PatternCreationViewController: RootViewController {
    
    // MARK: - UI Properties
    private var patternImage = UIImageView()
    private var editPhotoButton = UIButton(type: .system)
    private var patternTypeLabel = UILabel()
    private let chooseTypeButton = UIButton()
    
    private var patternNameTextField = UITextField()
    private var editButton: UIBarButtonItem!
    private let patternDescription = UITextView()
    private let descriptionTitleLabel = UILabel()
    
    
    // MARK: - Properties
    private var storeManager = StorageManager.shared
    private var patternType: PatternType?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Objc methods
    @objc func didTapRightBarButton() {
        if let type = patternType, let name = patternNameTextField.text {
            var newPattern = Pattern(type: type, name: name)
            newPattern.image = patternImage.image
            newPattern.description = patternDescription.text
            
            storeManager.addNewPattern(newPattern)
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(
                title: "Заполните поля",
                message: "Внесите имя и выберете тип паттерна",
                preferredStyle: .alert
            )
            
            let okButton = UIAlertAction(title: "ОК", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
        
    }
    
    @objc func cancelEditing() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func choosePatternTypeButtonTapped() {
        let bottomVC = BottomSheetViewController()
        bottomVC.delegate = self
        present(bottomVC, animated: true,)
    }
    
    @objc func choosePhoto() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "Фото", style: .default) { _ in
            self.openPhotoGallery()
        }
        let file = UIAlertAction(title: "Файлы", style: .destructive) { _ in
            // TODO Работа с файлами
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(file)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
}

// MARK: - Private Methods
private extension PatternCreationViewController {
    
    // MARK: - Setup View
    func setupView() {
        setupUI()
        //        updateData(with: object)
        setUpNavigationBar()
        addViews()
        setupConstraints()
    }
    
    // MARK: - Setup NavBar
    func setUpNavigationBar() {
        editButton = UIBarButtonItem(
            image: UIImage(resource: .done),
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton),
        )
        navigationItem.rightBarButtonItem = editButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelEditing)
        )
        navigationItem.title = "Паттерн проектирвония"
    }
    
    // MARK: - Setup UI
    func setupUI() {
        editPhotoButton.setTitle("Выбрать изображение", for: .normal)
        editPhotoButton.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        
        patternImage.layer.borderWidth = 1
        patternImage.layer.borderColor = UIColor.black.cgColor
        patternImage.layer.cornerRadius = 8
        patternImage.clipsToBounds = true
        patternImage.image = UIImage(resource: .no)
        
        patternNameTextField.font = UIFont(name: "SFPro-Semibold", size: 32)
        patternNameTextField.placeholder = "Название паттерна"
        patternNameTextField.rightView = UIImageView(image: UIImage(resource: .pencil))
        patternNameTextField.rightViewMode = .always
        patternNameTextField.layer.borderWidth = 1
        patternNameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        patternNameTextField.layer.cornerRadius = 8
        
        patternTypeLabel.text = "Выбрать тип паттерна"
        patternTypeLabel.textColor = UIColor.placeholderText
        patternTypeLabel.layer.borderWidth = 1
        patternTypeLabel.layer.cornerRadius = 8
        patternTypeLabel.layer.borderColor = UIColor.systemGray4.cgColor
        patternTypeLabel.font = UIFont(name: "SFPro-Semibold", size: 20)
        
        chooseTypeButton.setImage(UIImage(resource: .chevronUP), for: .normal)
        chooseTypeButton.tintColor = .black
        chooseTypeButton.addTarget(self, action: #selector(choosePatternTypeButtonTapped), for: .touchUpInside)
        
        patternDescription.font = UIFont(name: "SFPro-Regular", size: 16)
        patternDescription.layer.borderWidth = 1
        patternDescription.layer.borderColor = UIColor.systemGray4.cgColor
        patternDescription.layer.cornerRadius = 8
        
        descriptionTitleLabel.text = "Описание паттерна"
        descriptionTitleLabel.font = UIFont.sfProSemibold(with: .large)
        descriptionTitleLabel.textColor = UIColor.placeholderText
        
        self.view.backgroundColor = UIColor.systemBackground
    }
    
    // MARK: - Add Views
    func addViews() {
        view.addSubview(patternImage)
        view.addSubview(editPhotoButton)
        view.addSubview(patternNameTextField)
        view.addSubview(patternTypeLabel)
        view.addSubview(chooseTypeButton)
        view.addSubview(patternDescription)
        view.addSubview(descriptionTitleLabel)
    }
    
    // MARK: - Constraints Setup
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        
        patternImage.snp.makeConstraints { make in
            make.size.equalTo(screenWidth / 2)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(patternImage.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        patternNameTextField.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        patternTypeLabel.snp.makeConstraints { make in
            make.leading.equalTo(patternNameTextField)
            make.top.equalTo(patternNameTextField.snp.bottom).offset(24)
        }
        
        chooseTypeButton.snp.makeConstraints { make in
            make.bottom.top.equalTo(patternTypeLabel)
            make.trailing.equalTo(patternNameTextField)
            make.size.equalTo(24)
            
        }
        
        patternDescription.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(patternTypeLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Open Photo Gallery
    func openPhotoGallery() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - Work with Image Methods
extension PatternCreationViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let provider = results.first?.itemProvider else { return }
        
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                DispatchQueue.main.async {
                    self?.patternImage.image = image as? UIImage
                }
            }
        }
    }
}

// MARK: - PatternCreationViewControllerDelegate
extension PatternCreationViewController: BottomSheetDelegate {
    func updatePatternType(_ patternType: PatternType) {
        patternTypeLabel.text = "Тип: \(patternType.title)"
        patternTypeLabel.textColor = UIColor.black
        self.patternType = patternType
        print(patternType)
    }
}

// MARK: - UI TextField Delegate
extension PatternCreationViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

