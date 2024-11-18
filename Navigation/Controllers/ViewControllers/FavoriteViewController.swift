//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Yoji on 17.10.2023.
//

import UIKit

final class FavoriteViewController: UIViewController {
    private let viewModel: FavoriteViewModelProtocol
    
    // MARK: Views
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.estimatedRowHeight = 100
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var filterBarButton = UIBarButtonItem(
        image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
        style: .plain,
        target: self,
        action: #selector(filterBtnDidTap)
    )
    
    private lazy var unfilterBarButton = UIBarButtonItem(
        image: UIImage(systemName: "line.3.horizontal.circle"),
        style: .plain,
        target: self,
        action: #selector(unfilterBtnDidTap)
    )
    
    // MARK: Lifecycle
    init(viewModel: FavoriteViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Configuration.viewControllerBackgroundColor
        self.setupViews()
        self.setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateNavigation()
        self.reloadData()
    }
    
    // MARK: Setups
    private func setupViews() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupNavigation() {
        self.updateNavigation()
        self.navigationItem.setRightBarButtonItems([unfilterBarButton, filterBarButton], animated: true)
    }
    
    private func updateNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.unfilterBarButton.isEnabled = false
        self.navigationItem.title = "Favorite".localized
    }
    
//    MARK: Actions
    @objc private func filterBtnDidTap() {
        self.viewModel.updateState(viewInput: .filterBtnDidTap { filterString in
            if let filter = filterString {
                self.navigationItem.title = "Favorite by".localized + filter
                self.tableView.reloadData()
                self.unfilterBarButton.isEnabled = true
            } else {
                AlertUtils.showUserMessage("Author not exist".localized, context: self)
            }
        })
    }
    
    @objc private func unfilterBtnDidTap() {
        self.reloadData()
        self.unfilterBarButton.isEnabled = false
        self.navigationItem.title = "Favorite".localized
    }
    
//    MARK: Methods
    private func reloadData() {
        self.viewModel.updateState(viewInput: .refreshData)
        self.tableView.reloadData()
    }
}


// MARK: Extensions
extension FavoriteViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaltCell", for: indexPath)
            return cell
        }
        let post = viewModel.data[indexPath.row]
        cell.clipsToBounds = true
        cell.setup(with: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remove") {_,_,_ in
            self.viewModel.updateState(viewInput: .removeFromFavorite(indexPath.row))
            self.tableView.performBatchUpdates {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}
