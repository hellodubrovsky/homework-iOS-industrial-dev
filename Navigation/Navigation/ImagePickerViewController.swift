//
//  ImagePickerViewController.swift
//  Navigation
//
//  Created by Илья on 30.07.2022.
//

import UIKit


// MARK: - ImagePickerViewController

class ImagePickerViewController: UIImagePickerController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourceType = .photoLibrary
        self.delegate = self
    }
}





// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            // тут должно происходить сохранение фотографии.
            print("🖼 Image: \(image)")
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
