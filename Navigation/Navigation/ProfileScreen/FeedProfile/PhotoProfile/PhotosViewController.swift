//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Илья on 24.01.2022.
//

import UIKit
import iOSIntPackage


final class PhotosViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        self.activityIndicator.startAnimating()
        downloadPhotos()
    }
    
    
    
    // MARK: - Private properties.
    
    //private let imageFacade = ImagePublisherFacade()
    private let imageProcessor = ImageProcessor()
    private var imagesUser: [UIImage] = []
    
    private let collectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        return indicator
    }()
    
    
    
    // MARK: - Private methods
    
    private func downloadPhotos() {
        let imagesFull: [UIImage] = photosNameProfiles.map { UIImage(named: $0.imageName)! }
        let methodStart = NSDate()
        self.imageProcessor.processImagesOnThread(sourceImages: imagesFull, filter: .fade, qos: .utility) { images in
            self.imagesUser = images.map { UIImage(cgImage: $0!) }
            let methodFinish = NSDate()
            let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
            print("Время выполнения метода отображения коллекции фото: \(executionTime)")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    // MARK: - View configuration.
    
    private func settingView() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor.systemBlue
        navigationController?.navigationBar.isHidden = false
        
        title = "Photo Gallery"
        view.backgroundColor = .systemGray
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        installinConstraints()
    }
    
    private func installinConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}





// MARK: - Setting tableView (DataSource)

extension PhotosViewController: UICollectionViewDataSource {
    
    // Сколько ячеек, будет в одной секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUser.count
    }
    
    // Заполнение ячеек данными.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { fatalError() }
        let data = imagesUser[indexPath.row]
        cell.update(with: data, for: .profilePhoto)
        return cell
    }
}





// MARK: - Setting tableView (Delegate)

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    // Определение размера ячеек.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 8.0)
        return CGSize(width: width, height: width)
    }

    // Подсчет ширины ячеек.
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpasing: CGFloat = 3 * spacing + (itemsInRow - 2) * spacing
        let finalWidth = (width - totalSpasing) / itemsInRow
        return floor(finalWidth)
    }

    // Расстоновка отсутпов между ячейками.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
