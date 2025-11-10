//
//  PatternDetailsRouter.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 07.11.2025.
//

import Foundation
import UIKit
import PhotosUI

protocol PatternDetailsRouterInput {
    func close()
    func showBottomSheet(selectedType: PatternType)
    func showImageSourceAlert()
    func showImagePicker()
    func showImageViewer(with data: Data)
}

final class PatternDetailsRouter: PatternDetailsRouterInput {
   
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func close() {
        if let navVC = viewController?.navigationController {
            navVC.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
    
    func showBottomSheet(selectedType: PatternType) {
        let bottomSheet = BottomSheetViewController(selectedType: selectedType)
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
    
    func showImageViewer(with data: Data) {
        guard let image = UIImage(data: data) else {return}
        let viewer = ImageViewerViewController(image: image)
        
        viewController?.navigationController?.pushViewController(viewer, animated: true)
    }
}
