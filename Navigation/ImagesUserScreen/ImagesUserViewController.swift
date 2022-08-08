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
    private var sortAlphabetically: Bool = UserDefaults.standard.bool(forKey: "sortAlphabetically")
    
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
        let valueInUserDefaults: Bool = UserDefaults.standard.bool(forKey: "sortAlphabetically")
        if valueInUserDefaults != self.sortAlphabetically {
            self.sortAlphabetically = valueInUserDefaults
            updateData()
        }
    }
    
    
    // MARK: Private methods
    
    private func setView() {
        title = "User Images"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "colorBaseVK")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
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
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func getData() {
        self.activityIndicator.startAnimating()
        if UserDefaults.standard.object(forKey: "sortAlphabetically") == nil {
            self.sortAlphabetically = true
        }
        DispatchQueue.global().async {
            self.images = PhotoFileManager.shared.gettingImages(sortAlphabetically: self.sortAlphabetically)
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
    
    private func showAlertAboutDeletingAnImage(for indexPath: IndexPath) {
        let alert = UIAlertController(title: "Confirmation of deletion", message: "Are you sure you want to delete the selected image?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            PhotoFileManager.shared.remove(image: (self?.images[indexPath.row])!)
            self?.updateData()
        })
        self.present(alert, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showAlertAboutDeletingAnImage(for: indexPath)
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


extension UserDefaults {
    @objc dynamic var sortAlphabetically: Bool {
        return bool(forKey: "sortAlphabetically")
    }
}
