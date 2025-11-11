//
//  PatternCreationRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 10.11.2025.
//

import Foundation
import UIKit
import PhotosUI

protocol PatternCreationRouterInput: AnyObject {
    func close()
    func showBottomSheet()
    func showImageSourceAlert()
    func showImagePicker()
    func showCreationErrorAlert()
}


final class PatternCreationRouter: PatternCreationRouterInput {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showBottomSheet() {
        let bottomSheet = BottomSheetViewController(selectedType: nil)
        bottomSheet.delegate = viewController as? BottomSheetDelegate
        viewController?.present(bottomSheet, animated: true)
    }
    
    func showImageSourceAlert() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photo = UIAlertAction(title: "Фото", style: .default) { _ in
            self.showImagePicker()
        }
        let file = UIAlertAction(title: "Файлы", style: .destructive) { _ in
            // TODO Работа с файлами
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(file)
        actionSheet.addAction(cancel)
        
        viewController?.present(actionSheet, animated: true)
    }
    
    func showImagePicker() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = viewController as? PHPickerViewControllerDelegate
        viewController?.present(picker, animated: true)
    }
    
    func showCreationErrorAlert() {
        let alert = UIAlertController(
            title: "Заполните поля",
            message: "Внесите имя и выберете тип паттерна",
            preferredStyle: .alert
        )
        
        let okButton = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(okButton)
        viewController?.present(alert, animated: true)
    }
    
}
