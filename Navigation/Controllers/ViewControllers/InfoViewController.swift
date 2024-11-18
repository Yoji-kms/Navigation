//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//
//
import UIKit

final class InfoViewController: UIViewController {
    private let viewModel: InfoViewModelProtocol
    weak var delegate: RemoveChildCoordinatorDelegate?
    
    private var residents: [Resident] = []
    
// MARK: Views
    private lazy var button: UIButton = {
        let title = "Print message".localized
        let button = CustomButton(
            title: title,
            titleColor: nil,
            backgroundColor: .systemMint,
            onBtnTap: didTapButton
        )
        return button
    }()
    
    private lazy var todoLabel: UILabel = {
        let lbl = UILabel()
        Task {
            let todo = await viewModel.updateStateNet(task: .getTodoTitle) as? String
            lbl.text = "Todo: \(todo ?? "")"
        }
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private lazy var planetLabel: UILabel = {
        let lbl = UILabel()
        let title = "Tatuin orbital period: "
        lbl.text = title

        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    private lazy var residentsTable: UITableView = {
        let tbl = ResidentTableView(frame: .zero, style: .plain)
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "ResidentCell")
        tbl.dataSource = self
        tbl.estimatedRowHeight = 24
        tbl.translatesAutoresizingMaskIntoConstraints = false
        return tbl
    }()
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        self.view.backgroundColor = .lightGray
 
        self.setupViews()
        self.bindViewModel()
        self.viewModel.updateState(viewInput: .loadData)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.button.layer.cornerRadius = self.button.frame.height/4
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let coordinator = (self.viewModel as? InfoViewModel)?.coordinator else {
            return
        }
        delegate?.remove(childCoordinator: coordinator)
    }
    
    init(viewModel: InfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: Setups
    private func setupViews() {
        self.view.addSubview(button)
        self.view.addSubview(todoLabel)
        self.view.addSubview(planetLabel)
        self.view.addSubview(residentsTable)
        
        NSLayoutConstraint.activate([
            self.todoLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.todoLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.todoLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.planetLabel.topAnchor.constraint(equalTo: self.todoLabel.bottomAnchor, constant: 16),
            self.planetLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.planetLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.residentsTable.topAnchor.constraint(equalTo: self.planetLabel.bottomAnchor, constant: 16),
            self.residentsTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.residentsTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            self.button.topAnchor.constraint(equalTo: self.residentsTable.bottomAnchor, constant: 16),
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                ()
            case .loaded(let residents, let planet):
                DispatchQueue.main.async {
                    self.residents = residents
                    self.residentsTable.reloadData()
                    let title = "Tatuin orbital period: \(planet?.orbitalPeriod ?? "")"
                    self.planetLabel.text = title
                }
            }
        }
    }
    
// MARK: Actions
    private func didTapButton(){
        self.viewModel.updateState(viewInput: .printMessageBtnDidTap)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResidentCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = residents[indexPath.row].name        
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
