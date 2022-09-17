//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Илья Дубровский on 13.09.2022.
//

import UIKit
import StorageService

final class FavoritePostsViewController: UIViewController {
    
    // MARK: Private properies
    
    private enum State {
        case empty
        case hasData(model: [PostUsers])
    }
    
    private let databaseService: DatabaseCoordinatable
    private var state: State = .empty
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 186
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(FavoritePostTableViewCell.self, forCellReuseIdentifier: "FavoritePostsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    // MARK: Initial
    
    init(databaseService: DatabaseCoordinatable) {
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Life cycle view

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.fetchPostsFromDatabase()
        NotificationCenter.default.addObserver(self, selector: #selector(wasLikedPost(_:)), name: Notification.Name("wasLikedPost"), object: nil)
        
        #if DEBUG
        self.configuringFunctionalityForDeveloper()
        #endif
    }
    
    
    
    // MARK: Private methods
    
    private func setView() {
        self.title = "Favorite posts"
        self.view.addSubview(tableView)
        let rightContraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let leftConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let topContraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([rightContraint, leftConstraint, topContraint, bottomConstraint])
    }
    
    // Use only for debug-build.
    private func configuringFunctionalityForDeveloper() {
        let tabBarButton = UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(deleteAllPostsInDataBase))
        tabBarButton.tintColor = .red
        self.navigationItem.rightBarButtonItem = tabBarButton
    }
    
    private func fetchPostsFromDatabase() {
        self.databaseService.fetchAll(FavoritePostCoreDataModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favoritePostsCoreDataModel):
                let posts = favoritePostsCoreDataModel.map { PostUsers(title: $0.title!,
                                                                       description: $0.descriptionPost!,
                                                                       imageName: $0.imageName!,
                                                                       countLikes: UInt($0.countLikes),
                                                                       countViews: UInt($0.countViews)) }
                self.state = posts.isEmpty ? .empty : .hasData(model: posts)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func wasLikedPost(_ notification: NSNotification) {
        guard self.isViewLoaded else { return }
        if let post = notification.userInfo?["post"] as? PostUsers {
            switch self.state {
            case .empty:
                if post.isFavorite {
                    let model = [post]
                    self.state = .hasData(model: model)
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                }
            case .hasData(let model):
                var newModel = model
                if post.isFavorite {
                    newModel.append(post)
                    self.state = .hasData(model: newModel)
                    let lastIndex = newModel.count - 1
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath(row: lastIndex, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                } else {
                    guard let index = model.firstIndex(where: { $0 == post }) else { return }
                    newModel.remove(at: index)
                    self.state = .hasData(model: newModel)
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                }
            }
        }
    }
    
    // Methods only for debug-build.
    @objc private func deleteAllPostsInDataBase() {
        self.databaseService.deleteAll(FavoritePostCoreDataModel.self) { _ in }
    }
}





// MARK: - TableViewDataSource & Delegate

extension FavoritePostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .empty:
            return 0
        case .hasData(let model):
            return model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.state {
        case .empty:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        case .hasData(let model):
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoritePostsCell", for: indexPath) as? FavoritePostTableViewCell else {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let post = model[indexPath.row]
            let favoriteModel = FavoritePostTableViewCell.ViewModel(title: post.title, image: UIImage(named: post.imageName)!, description: post.description, countLikes: post.countLikes, countViews: post.countViews)
            cell.setup(with: favoriteModel)
            return cell
        }
    }
}
