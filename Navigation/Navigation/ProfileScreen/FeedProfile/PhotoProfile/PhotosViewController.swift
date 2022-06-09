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
        imageFacade.subscribe(self)
        imageFacade.addImagesWithTimer(time: 0.2, repeat: photosNameProfiles.count)
    }
    
    
    
    // MARK: - Private properties.
    
    private let imageFacade = ImagePublisherFacade()
    private let imageProcessor = ImageProcessor()
    private var imagesUser: [UIImage] = []
    
    private let collectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    deinit {
        imageFacade.rechargeImageLibrary()
        imageFacade.removeSubscription(for: self)
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        installinConstraints()
    }
    
    private func installinConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        let data = photosNameProfiles[indexPath.row]
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





// MARK: - Protocol:

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        let methodStart = NSDate()
        
        // Пару примеров:
        // C параметром .fade общее время выполнения: 53.5875209569931
        // C параметром .noir общее время выполнения: 65.24861896038055
        
        self.imageProcessor.processImagesOnThread(sourceImages: images, filter: .fade, qos: .utility) { images in
            DispatchQueue.main.async {
                self.imagesUser = []
                for i in images {
                    guard let image = i else { return }
                    self.imagesUser.append(UIImage(cgImage: image))
                }
                let methodFinish = NSDate()
                let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
                print("Время выполнения метода: \(executionTime)")
                self.collectionView.reloadData()
            }
        }
    }
}
