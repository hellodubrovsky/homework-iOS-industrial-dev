//
//  FileManager.swift
//  Navigation
//
//  Created by Илья on 30.07.2022.
//

import Foundation
import UIKit


// MARK: - PhotoFileManagerProtocol

protocol PhotoFileManagerProtocol: AnyObject {
    func gettingImages(sortAlphabetically: Bool) -> [UIImage]
    func savingAn(image: UIImage)
    func remove(image: UIImage)
}





// MARK: - FileManager

final class PhotoFileManager: PhotoFileManagerProtocol {
    
    // MARK: Static properties
    static var shared: PhotoFileManager { PhotoFileManager() }
    
    
    // MARK: Private propreties
    private let manager: FileManager = FileManager.default
    
    
    // MARK: Public methods
    
    /// Метод получения всех фотографии, в папке Documents.
    func gettingImages(sortAlphabetically: Bool) -> [UIImage] {
        var imagesDictionary: [String: UIImage] = [:]
        do {
            let documentsURL = try self.manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contentsURL = try self.manager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for fileURL in contentsURL {
                guard let image = UIImage(contentsOfFile: fileURL.path) else { continue }
                let nameImage = fileURL.lastPathComponent
                imagesDictionary[nameImage] = image
            }
            return sorted(dictionary: imagesDictionary, sortAlphabetically: sortAlphabetically)
        } catch let error {
            print("Ошибка в получении пути к папке documents: \(error)")
            return []
        }
    }

    /// Метод сохранения фотографии в папку Documents.
    func savingAn(image: UIImage) {
        do {
            let documentsURL = try self.manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let dataImage = image.jpegData(compressionQuality: 1.0)
            let randomString = NSUUID().uuidString
            let imagePath = documentsURL.appendingPathComponent("\(randomString).jpeg")
            self.manager.createFile(atPath: imagePath.path, contents: dataImage)
        } catch let error {
            print("Ошибка в получении пути к папке documents: \(error)")
        }
    }

    /// Метод удаления фотографии из папки Documents.
    func remove(image: UIImage) {
        do {
            let documentsURL = try self.manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let contentsURL = try self.manager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for fileURL in contentsURL {
                guard let imageBeingDeleted = UIImage(contentsOfFile: fileURL.path) else { continue }
                let dataImage = image.jpegData(compressionQuality: 1.0)
                let dataImageBeingDeleted = imageBeingDeleted.jpegData(compressionQuality: 1.0)
                guard dataImage == dataImageBeingDeleted else { continue }
                try self.manager.removeItem(at: fileURL)
            }
        } catch let error {
            print("Ошибка в получении пути к папке documents: \(error)")
        }
    }
    
    /// Метод, для сортировки значениий словаря, по ключам.
    private func sorted(dictionary: [String: UIImage], sortAlphabetically: Bool) -> [UIImage] {
        let sortedDic = dictionary.sorted { $0.key < $1.key }
        var sortedArrayImage: [UIImage] = []
        sortedDic.forEach { sortedArrayImage.append($0.value) }
        guard sortAlphabetically else { return sortedArrayImage.reversed() }
        return sortedArrayImage
    }
}
