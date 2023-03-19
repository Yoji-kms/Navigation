//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
// MARK: Variables
    private let viewModel: ProfileViewModelProtocol
    
// MARK: Views
    private lazy var closeAvatarBtn: CustomButton = {
        let btn = CustomButton(title: nil, titleColor: nil, backgroundColor: nil, onBtnTap: closeAvatarBtnDidTap)
        btn.alpha = 0
        btn.tintColor = .systemRed
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.isEnabled = false
        btn.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.estimatedRowHeight = 100
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
// MARK: Variables for animation
    private var avatarStartPoint: CGPoint?
    private var avatarScaleCoefficient: CGFloat?
    private var avatarView: AvatarView?
    
// MARK: Lifecycle
    init(viewModel: ProfileViewModelProtocol) {
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
        self.setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
// MARK: Setups
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.closeAvatarBtn)
       
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.closeAvatarBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.closeAvatarBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
// MARK: Actions
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        self.tableView.endEditing(true)
    }
    
    private func closeAvatarBtnDidTap() {
        guard let avatar = avatarView else { return }
        guard let avatarStartPoint = avatarStartPoint else { return }
        guard let avatarScaleCoefficient = avatarScaleCoefficient else { return }
        let coefficient = 3 * (1/avatarScaleCoefficient)
        
        self.closeAvatarBtn.isEnabled = false
                
        UIView.animateKeyframes(withDuration: 0.8, delay: 0.0, options: .calculationModePaced){
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                self.closeAvatarBtn.alpha = 0.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                avatar.fadingView.alpha = 0.0
                avatar.avatarImageView.center = avatarStartPoint
                avatar.avatarImageView.transform = CGAffineTransform(scaleX: coefficient, y: coefficient)
                avatar.avatarImageView.layer.cornerRadius = avatar.avatarImageView.bounds.height/2
            }
        } completion: { _ in
            self.tableView.isUserInteractionEnabled = true
        }
    }
    
    private lazy var tapRecognizer: UIGestureRecognizer = {
        let recognizer = UIGestureRecognizer()
        recognizer.delegate = self
        return recognizer
    }()
    
    private func pushToPhotosVC() {
        self.viewModel.updateState(viewInput: .photosDidTap(viewModel.photos))
    }
}

// MARK: Extensions
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel.posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeafaultCell", for: indexPath)
                return cell
            }
            cell.addGestureRecognizer(tapRecognizer)
            cell.setup(with: viewModel.photos)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaltCell", for: indexPath)
                return cell
            }
            let post = viewModel.posts[indexPath.row]
            cell.clipsToBounds = true
            cell.setup(with: post)
            cell.delegate = self
            
            return cell
        default:
            assertionFailure("No registered section")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView else {
                return nil
            }
            let user = self.viewModel.user
            headerView.setup(with: user)
            headerView.delegate = self
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }
}

extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        gestureRecognizer.allowedTouchTypes = [0]
        if (touch.type == .direct) {
            pushToPhotosVC()
            return true
        }
        return false
    }
}

extension ProfileViewController: AvatarTapDelegate {
    func avatarTap(avatar: AvatarView) {
        let screeenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let screenCenter = CGPoint(x: self.view.bounds.midX - 16, y: self.view.bounds.midY - 16)
        
        self.avatarView = avatar
        self.avatarStartPoint = avatar.avatarImageView.center
        self.avatarScaleCoefficient = screeenWidth / ((avatar.avatarImageView.image?.size.width ?? 1)/2)
        
        let coefficient = self.avatarScaleCoefficient ?? 1
        let fadingWidthCoefficient = screeenWidth / ((avatar.fadingView.bounds.width)/2)
        let fadingHeightCoefficient = screenHeight / ((avatar.fadingView.bounds.height)/2)
        avatar.fadingView.center = screenCenter
        avatar.fadingView.transform = CGAffineTransform(scaleX: fadingWidthCoefficient, y: fadingHeightCoefficient)
    
        self.tableView.isUserInteractionEnabled = false
        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0.0, options: .calculationModePaced){
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                avatar.fadingView.alpha = 0.5
                avatar.avatarImageView.center = screenCenter
                avatar.avatarImageView.layer.cornerRadius = 0
                avatar.avatarImageView.transform = CGAffineTransform(scaleX: coefficient, y: coefficient)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3) {
                self.closeAvatarBtn.alpha = 1.0
            }
        } completion: { _ in
            self.closeAvatarBtn.isEnabled = true
        }
    }
}

extension ProfileViewController: StartPlayerDelegate {
    func start(audio: String, playlist: [String]) {
        self.viewModel.updateState(viewInput: .audioDidTap(audio, playlist))
    }
}
