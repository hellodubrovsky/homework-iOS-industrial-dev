//
//  ImagesUserViewController.swift
//  Navigation
//
//  Created by Илья on 31.07.2022.
//

import UIKit

class ImagesUserViewController: UIViewController {
    
    
    // MARK: Private properties
    private var images: [UIImage] = []
    
    private let collectionView: UICollectionView = {
        var viewLayout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        installingConstraints()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("yes")
    }
    
    
    // MARK: Private methods
    
    private func setView() {
        title = "User images"
        view.backgroundColor = .systemGray
        navigationController?.navigationBar.tintColor = . white
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImagesUserCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("addNewImageInFolderDocuments"), object: nil)
    }
    
    private func installingConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func getData() {
        self.activityIndicator.startAnimating()
        DispatchQueue.global().async {
            self.images = PhotoFileManager.shared.gettingImages()
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc private func updateData() {
        self.images = []
        self.collectionView.reloadData()
        getData()
    }
}





// MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension ImagesUserViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ImagesUserCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImagesUserCollectionViewCell else { fatalError() }
        let data = images[indexPath.row]
        cell.update(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 8.0)
        return CGSize(width: width, height: width)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 3
        let totalSpasing: CGFloat = 3 * spacing + (itemsInRow - 2) * spacing
        let finalWidth = (width - totalSpasing) / itemsInRow
        return floor(finalWidth)
    }

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
