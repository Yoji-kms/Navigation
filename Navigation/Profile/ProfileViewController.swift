//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Yoji on 27.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    //MARK: Variables
    private lazy var data: [Post] = {
        let data = [
            Post(title: "Песочный человек",
                 description: "\"Сэндмену\" недаром нет равных среди графических романов по числу престижных наград и премий, равно как и по числу похвальных отзывов критиков и читателей. \"Сэндмен\" — это полный тайн и открытий сюжет с глубоким философским подтекстом, прописанный гениальным пером Нила Геймана и иллюстрированный лучшими художниками в жанре комикса, \"Сэндмен\" — это колдовская смесь мифа и темной фэнтези, где сплетаются воедино множество жанров, от исторического романа до детектива. Подобных саг, где одна таинственная, будоражащая душу, история плавно перетекает в другую, не менее таинственную, мир графических романов прежде не видел. Однажды прочитав, \"Сэндмена\" невозможно забыть.",
                 image: "Photos/sandman",
                 likes: 455,
                 views: 4444),
            Post(title: "Ключи Локков",
                 description: "\"Ключи Локков\", написанные Джо Хиллом и нарисованные Габриэлем Родригезом, расскажут вам о Доме Ключей, необычном особняке в Новой Англии, сказочные двери которого изменяют каждого, кто осмелится пройти сквозь них... где обидает переполненное ненавистью, жестокое существо, что не упокоится, пока не отворит самую страшную из дверей.",
                 image: "Photos/LockeAndKey",
                 likes: 455,
                 views: 562),
            Post(title: "Академия Амбрелла",
                 description: "Это нестандартный, свежий и яркий комикс. В центре повествования – команда супергероев, которые встречаются вновь после смерти их приёмного отца – Профессора, чтобы в очередной раз спасти мир. Но у них нет плащей и обтягивающего трико – они обычные  люди со своими проблемами, просто чуть-чуть сильнее. В российском издании обе части комикса  – \"Сюита Апокалипсиса\" и  \"Даллас\". В первой – весь мир под угрозой... музыки, а \"Даллас\"расскажет свою версию событий убийства президента Кеннеди.",
                 image: "Photos/UmbrellaAcademy",
                 likes: 44,
                 views: 312),
            Post(title: "Хранители",
                 description: "Альтернативная реальность. 1985-й год. Президентом США все еще является Никсон и Холодная война все так же актуальна. Восемь лет назад супергерои были объявлены вне закона. Теперь они живут как обычные люди, хотя прежние годы регулярно дают о себе знать. И вот один из них жестоко убит. Люди, убравшие свои разноцветные костюмы в шкафы, не стали бы этим интересоваться, если бы не настойчивость единственного, кто не сдался семь лет назад, — Роршаха. На дворе самый разгар Холодной войны, у его бывших коллег разные профессии и взгляды на мир, а Роршах уверен, что все они оказались в эпицентре злодейского заговора.",
                 image: "Photos/Watchmen",
                 likes: 453,
                 views: 8512),
            Post(title: "Сказки",
                 description: "Представьте себе, что все наши самые любимые сказки оказались реальными людьми и поселились среди нас, сохранив все свои волшебные свойства. Как им удастся выжить в нашем обыкновенном, лишенном колдовства мире? «СКАЗКИ» - великолепная вариация на тему сказочного канона, придуманная Биллом Уиллингхэмом, дает ответ на этот вопрос. К нам возвращаются Бела Снежка и Бигби Волк, Златовласка и Мальчик-Пастушок – возвращаются как изгнанники, которые живут, хитроумно замаскировавшись, в одном из районов Нью-Йорка под названием Сказкитаун.",
                 image: "Photos/Fables",
                 likes: 5,
                 views: 15)
        ]
        return data
    }()
    
    private lazy var photos:[String] = {
        let strings = [
            "Photos/Dai Dark",
            "Photos/Dorohedoro",
            "Photos/Fables",
            "Photos/Lock and Key",
            "Photos/LockeAndKey",
            "Photos/ManyDeathsLailaStarr",
            "Photos/ManyDeathsLailaStarr 2",
            "Photos/Maus",
            "Photos/Miracleman_Vol_1_1",
            "Photos/Parasyte",
            "Photos/Sandman drem hunters",
            "Photos/Sandman Overture",
            "Photos/sandman",
            "Photos/Scott Pilgrim",
            "Photos/Seconds",
            "Photos/The Walking Dead 1",
            "Photos/The Walking Dead 2",
            "Photos/The Walking Dead 3",
            "Photos/The-Boys",
            "Photos/UmbrellaAcademy",
            "Photos/Watchmen"
        ]
        return strings
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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = NSLocalizedString("Profile", comment: "Profile")
        self.view.backgroundColor = .systemGray6
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
    
    //MARK: Setups
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupViews() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: Actions
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
    
    private lazy var tapRecognizer: UIGestureRecognizer = {
        let recognizer = UIGestureRecognizer()
        recognizer.delegate = self
        return recognizer
    }()
    
    private func pushToPhotosVC() {
        let photosVC = PhotosViewController()
        photosVC.data = self.photos
        
        self.navigationController?.pushViewController(photosVC, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DeafaultCell", for: indexPath)
                return cell
            }
            cell.clipsToBounds = true
            cell.addGestureRecognizer(tapRecognizer)
            cell.setup(with: photos)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaltCell", for: indexPath)
            return cell
        }
        let post = self.data[indexPath.row]
        cell.clipsToBounds = true
        cell.setup(with: post)
        
        return cell
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
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        }
        return 0
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
