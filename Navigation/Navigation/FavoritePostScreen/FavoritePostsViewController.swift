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
