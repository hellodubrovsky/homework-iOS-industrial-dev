//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Илья on 25.01.2022.
//

import UIKit

// Unique ID protocol.
protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Private objects.
    
    private var photoImageView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let photoImageViewFeed: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    enum ScreenProfile: String {
        case profileFeed
        case profilePhoto
    }
    
    
    
    // MARK: Private methods.
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
    }
    
    private func setupLayout() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func update(with photos: PhotoProfile, for screen: ScreenProfile) {
        switch screen {
        case .profilePhoto:
            photoImageView.image = UIImage(named: photos.imageName)
        case .profileFeed:
            photoImageView.clipsToBounds = true
            photoImageView.layer.cornerRadius = 6.0
            photoImageView.image = UIImage(named: photos.imageName)
        }
    }
}





// MARK: - Unique ID for collectionView
extension PhotosCollectionViewCell: ReusableView {
    static var identifier: String { String(describing: self) }
}
