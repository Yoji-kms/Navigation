//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Yoji on 28.09.2022.
//

import UIKit
import StorageService

final class PostTableViewCell: UITableViewCell {
    weak var startPlayerDelegate: StartPlayerDelegate?
    weak var videoTapDelegate: VideoTapDelegate?
    
    private lazy var audioData: [String] = []
    private lazy var audioTableHeight: CGFloat = 0
    private lazy var videoData: [(String, String)] = []
    private lazy var videoTableHeight: CGFloat = 0
    
    private enum Media {
        case audio
        case video
    }

    private func selectMedia(table: UITableView) -> Media {
        if table is AudioTableView {
            return .audio
        } else if table is VideoTableView {
            return .video
        } else {
            preconditionFailure("Unknown table type")
        }
    }
    
// MARK: Views
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var audioTable: AudioTableView = {
        let table = AudioTableView(frame: .zero, style: .plain)
        table.register(AudioTableViewCell.self, forCellReuseIdentifier: "AudioCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        table.dataSource = self
        table.isScrollEnabled = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var videoTable: VideoTableView = {
        let table = VideoTableView(frame: .zero, style: .plain)
        table.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likes: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var views: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
// MARK: Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.setupBasicViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        self.title.text = nil
        self.postDescription.text = nil
        self.audioData = []
        self.videoData = []
        self.views.text = nil
        self.likes.text = nil
    }
  
// MARK: Setups
    func setup(with viewModel: Post) {
        self.setupImage(data: viewModel.image)
        self.setupAudio(data: viewModel.audio)
        self.setupVideo(data: viewModel.video)
        
        self.title.text = viewModel.title
        self.postDescription.text = viewModel.description
        self.likes.text = NSLocalizedString("Likes", comment: "Likes") + String(viewModel.likes)
        self.views.text = NSLocalizedString("Views", comment: "Views") + String(viewModel.views)
        
        self.setupBasicViews()
    }
    
    private func setupBasicViews() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(image)
        self.contentView.addSubview(audioTable)
        self.contentView.addSubview(videoTable)
        self.contentView.addSubview(postDescription)
        self.contentView.addSubview(views)
        self.contentView.addSubview(likes)
        
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.image.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 16),
            self.image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1.0),
            
            self.videoTable.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 16),
            self.videoTable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.videoTable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.videoTable.heightAnchor.constraint(equalToConstant: self.videoTableHeight),
            
            self.postDescription.topAnchor.constraint(equalTo: self.videoTable.bottomAnchor, constant: 16),
            self.postDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.postDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            self.audioTable.topAnchor.constraint(equalTo: self.postDescription.bottomAnchor, constant: 16),
            self.audioTable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.audioTable.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.audioTable.heightAnchor.constraint(equalToConstant: self.audioTableHeight),
            
            self.likes.topAnchor.constraint(equalTo: self.audioTable.bottomAnchor, constant: 16),
            self.likes.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.likes.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            self.views.topAnchor.constraint(equalTo: self.audioTable.bottomAnchor, constant: 16),
            self.views.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.views.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupImage(data: String?) {
        if let image = data {
            self.image.image = UIImage(named: image)
        } else {
            self.image.remove()
        }
    }
    
    private func setupAudio(data: [String]) {
        if !data.isEmpty {
            self.audioData = data
            self.audioTableHeight = CGFloat(data.count * 44 - 16)
        } else {
            self.audioTable.remove()
        }
    }
    
    private func setupVideo(data: [(String, String)]) {
        if !data.isEmpty {
            self.videoData = data
            self.videoTableHeight = CGFloat(data.count * 44 - 16)
        } else {
            self.videoTable.remove()
        }
    }
}

extension PostTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let media = self.selectMedia(table: tableView)
        switch media {
        case .audio:
            return self.audioData.count
        case .video:
            return self.videoData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let media = self.selectMedia(table: tableView)
        switch media {
        case .audio:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioCell", for: indexPath) as? AudioTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.setup(with: self.audioData[indexPath.row])
            cell.delegate = self
            return cell
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.setup(with: self.videoData[indexPath.row])
            cell.delegate = videoTapDelegate
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostTableViewCell: AudioTapDelegate {
    func audioDidTap(name: String) {
        self.startPlayerDelegate?.start(audio: name, playlist: self.audioData)
    }
}

