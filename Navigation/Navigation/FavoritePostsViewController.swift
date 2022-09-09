//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Илья on 29.08.2022.
//

import UIKit
import StorageService

final class FavoritePostsViewController: UIViewController {
    
    private enum State {
        case empty
        case hasModel(model: [PostUsers])
    }
    
    
    
    // MARK: Private properties
    private var state: State = .empty
    private var databaseService: DatabaseCoordinatable2
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 186
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(FavoritePostsTableViewCell.self, forCellReuseIdentifier: "FavoritePostsCell")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    // MARK: Initial
    
    init(dataBaseService: DatabaseCoordinatable2) {
        self.databaseService = dataBaseService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.fetchPostsFromDatabase()
    }
    
    
    
    // MARK: Setup view
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Favorites Posts"
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leftConstraint = self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let rightConstraint = self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([ topConstraint, leftConstraint, rightConstraint, bottomConstraint ])
    }
    
    
    
    // MARK: DataBase
    
    private func fetchPostsFromDatabase() {
        self.databaseService.fetchAll(PostCoreDataModel.self) { result in
            switch result {
            case .success(let postCoreDataModel):
                let posts: [PostUsers] = postCoreDataModel.map { PostUsers(title: $0.title!, description: $0.descriptions!, imageName: $0.image!, likes: UInt($0.likes), views: UInt($0.views), uniqueID: $0.uniqueID!)}
                self.state = posts.isEmpty ? .empty : .hasModel(model: posts)
                self.tableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
                self.state = .empty
            }
        }
    }
}





// MARK: - UITableViewDelegate, UITableViewDataSource

extension FavoritePostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .empty:
            return 0
        case .hasModel(let model):
            return model.count
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.state {
        case .empty:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        case .hasModel(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritePostsCell", for: indexPath) as? FavoritePostsTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let post = model[indexPath.row]
            let favoriteModel = FavoritePostsTableViewCell.ViewModel(title: post.title, image: post.image, description: post.description, countLikes: post.likes, countViews: post.views, uniqueID: post.uniqueID)
            cell.setup(with: favoriteModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
