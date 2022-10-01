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
                 image: "sandman",
                 likes: 455,
                 views: 4444),
            Post(title: "Ключи Локков",
                 description: "\"Ключи Локков\", написанные Джо Хиллом и нарисованные Габриэлем Родригезом, расскажут вам о Доме Ключей, необычном особняке в Новой Англии, сказочные двери которого изменяют каждого, кто осмелится пройти сквозь них... где обидает переполненное ненавистью, жестокое существо, что не упокоится, пока не отворит самую страшную из дверей.",
                 image: "LockeAndKey",
                 likes: 455,
                 views: 562),
            Post(title: "Академия Амбрелла",
                 description: "Это нестандартный, свежий и яркий комикс. В центре повествования – команда супергероев, которые встречаются вновь после смерти их приёмного отца – Профессора, чтобы в очередной раз спасти мир. Но у них нет плащей и обтягивающего трико – они обычные  люди со своими проблемами, просто чуть-чуть сильнее. В российском издании обе части комикса  – \"Сюита Апокалипсиса\" и  \"Даллас\". В первой – весь мир под угрозой... музыки, а \"Даллас\"расскажет свою версию событий убийства президента Кеннеди.",
                 image: "UmbrellaAcademy",
                 likes: 44,
                 views: 312),
            Post(title: "Хранители",
                 description: "Альтернативная реальность. 1985-й год. Президентом США все еще является Никсон и Холодная война все так же актуальна. Восемь лет назад супергерои были объявлены вне закона. Теперь они живут как обычные люди, хотя прежние годы регулярно дают о себе знать. И вот один из них жестоко убит. Люди, убравшие свои разноцветные костюмы в шкафы, не стали бы этим интересоваться, если бы не настойчивость единственного, кто не сдался семь лет назад, — Роршаха. На дворе самый разгар Холодной войны, у его бывших коллег разные профессии и взгляды на мир, а Роршах уверен, что все они оказались в эпицентре злодейского заговора.",
                 image: "Watchmen",
                 likes: 453,
                 views: 8512),
            Post(title: "Сказки",
                 description: "Представьте себе, что все наши самые любимые сказки оказались реальными людьми и поселились среди нас, сохранив все свои волшебные свойства. Как им удастся выжить в нашем обыкновенном, лишенном колдовства мире? «СКАЗКИ» - великолепная вариация на тему сказочного канона, придуманная Биллом Уиллингхэмом, дает ответ на этот вопрос. К нам возвращаются Бела Снежка и Бигби Волк, Златовласка и Мальчик-Пастушок – возвращаются как изгнанники, которые живут, хитроумно замаскировавшись, в одном из районов Нью-Йорка под названием Сказкитаун.",
                 image: "Fables",
                 likes: 5,
                 views: 15)
        ]
        return data
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: . plain)
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        table.sectionHeaderHeight = 220
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
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
        self.navigationItem.title = NSLocalizedString("Profile", comment: "Profile")
        self.view.backgroundColor = .lightGray
        setupViews()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }
    
    @objc private func forcedHidingKeyboard() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        self.tableView.endEditing(true)
//        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaltCell", for: indexPath)
            return cell
        }
        let post = self.data[indexPath.row]
        cell.setup(with: post)
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView else { return nil }
        return headerView
    }
}
