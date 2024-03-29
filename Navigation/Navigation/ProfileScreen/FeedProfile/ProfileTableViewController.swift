//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Илья on 27.11.2021.
//

import UIKit
import StorageService
import iOSIntPackage

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
        self.coordinator.set(navigationController: self.navigationController!)
    }
    
    // Реализовано для того, чтобы при возврате из photosViewController'а скрывался navigationBar.
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    // MARK: - Public initializer
    
    init(userService: UserService, userName: String, databaseService: DatabaseCoordinatable) {
        super.init(nibName: nil, bundle: nil)
        self.userService = userService
        self.userName = userName
        self.databaseService = databaseService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Private properties
    
    private var userService: UserService!
    private var userName: String!
    private var coordinator: ProfileCoordinator = ProfileCoordinatorImplementation()
    private var databaseService: DatabaseCoordinatable!
    
    // Фильтр для постов
    private let imageProcessor = ImageProcessor()
    
    // ID для секциий.
    private enum cellReuseIdentifiers {
        static var photo: String = "uniqueCellForUserPhoto"
        static var posts: String = "uniqueCellForUserPosts"
    }
    
    private lazy var profileView: ProfileHeaderView = {
        guard let user = self.userService.searchUserBy(name: self.userName) else { fatalError() }
        let view = ProfileHeaderView(name: user.name, status: user.status, image: user.image)
        
        #if DEBUG
        view.backgroundColor = .systemBrown
        #else
        view.backgroundColor = .systemGray2
        #endif
        
        return view
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect.zero, style: .grouped)
        table.estimatedRowHeight = 16
        table.backgroundColor = .systemGray2
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    
    // MARK: - Private methods
    
    // Avatar (передаём размеры, чтобы можно было растянуть аватар на весь экран)
    private func transferOfViewSizes() {
        ProfileHeaderView.ConstraintsForAvatarAndItsBackground.center = view.center
        ProfileHeaderView.ConstraintsForAvatarAndItsBackground.width = view.frame.size.width
        ProfileHeaderView.ConstraintsForAvatarAndItsBackground.heightBackground = view.frame.size.height
    }
    
    private func saveInDatabase(post: PostUsers) {
        self.databaseService.create(FavoritePostCoreDataModel.self, keyedValue: post.keyedValue) { result in
            switch result {
            case .success(_):
                let userInfo = ["post": post]
                NotificationCenter.default.post(name: NSNotification.Name("wasLikedPost"), object: nil, userInfo: userInfo)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    // MARK: - View configuration
    
    // Настройка view
    private func settingView() {
        view.addSubview(tableView)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifiers.photo)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifiers.posts)
        tableView.dataSource = self
        tableView.delegate = self
        installingConstraints()
        transferOfViewSizes()
    }
    
    // Настройка констрейнтов
    private func installingConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}





// MARK: - Setting tableView

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Данный метод, должен понимать, сколько всего ячеек будет.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return posts.count }
        return 1
    }
    
    // Данный метод, отвечает за заполненение ячеек данными.
    /* https://medium.com/swift-gurus/generic-tableview-cells-and-sections-69c8ae241636 */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifiers.photo, for: indexPath) as? PhotosTableViewCell else { fatalError() }
            return cell
        default:
            guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifiers.posts, for: indexPath) as? PostTableViewCell else { fatalError() }
            let data = posts[indexPath.row]
            
            // Применение фильтров к изображениям постов
            var filter: ColorFilter?
            var image: UIImage?
            
            switch indexPath.row {
            case 0:
                filter = .motionBlur(radius: 10)
            case 1:
                filter = .crystallize(radius: 10)
            case 2:
                filter = .fade
            default:
                filter = .sepia(intensity: 20)
            }
            
            imageProcessor.processImage(sourceImage: UIImage(named: data.imageName)!, filter: filter!) { editedImage in
                image = editedImage
            }
            
            cell.delegate = self
            cell.update(name: data.title, image: image!, description: data.description, countLikes: data.countLikes, countViews: data.countViews)
            return cell
        }
    }
    
    // Добавляем profileView в качестве header'a.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return profileView
    }
    
    // Добавляем размер header'у.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        return 220
    }
    
    // Действие по нажатию на ячейку.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 && indexPath.row == 0 else { return }
        coordinator.openPhotoUserScreen()
    }
}




// MARK: - PostTableViewCellDelegate
 
extension ProfileViewController: PostTableViewCellDelegate {
    func doubleClickOnCell() {
        guard let index = self.tableView.indexPathForSelectedRow?.row else { return }
        guard posts[index].isFavorite != true else { return }
        posts[index].isFavorite = true
        let post = posts[index]
        let filter = post.uniqueID
        let predicate = NSPredicate(format: "uniqueID == %@", filter)
        self.databaseService.fetch(FavoritePostCoreDataModel.self, predicate: predicate) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                guard model.isEmpty else { return }
                self.saveInDatabase(post: post)
            case .failure(let error):
                print("[file: PostTableViewCellDelegate] Error: \(error)")
            }
        }
    }
}
