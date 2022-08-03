//
//  ImagesUserCollectionViewCell.swift
//  Navigation
//
//  Created by Илья on 31.07.2022.
//

import UIKit

final class ImagesUserCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public methods.
    
    func update(with photo: UIImage) {
        imageView.image = photo
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
    
    private var imageView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    // MARK: - View configuration.
    
    private func settingView() {
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        installingConstraints()
    }
    
    private func installingConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
