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

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public methods.
    
    func update(with photo: UIImage, for screen: ScreenProfile) {
        switch screen {
        case .profilePhoto:
            photoImageView.image = photo
        case .profileFeed:
            photoImageView.clipsToBounds = true
            photoImageView.layer.cornerRadius = 6.0
            photoImageView.image = photo
        }
    }
    
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Private properties.
    
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
    
    
    
    // MARK: - View configuration.
    
    private func settingView() {
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        installingConstraints()
    }
    
    private func installingConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}





// MARK: - Unique ID for collectionView

extension PhotosCollectionViewCell: ReusableView {
    static var identifier: String { String(describing: self) }
}
