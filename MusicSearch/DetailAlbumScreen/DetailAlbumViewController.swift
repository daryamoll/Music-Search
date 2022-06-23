
import UIKit

class DetailAlbumViewController: UIViewController {
    
    private enum Constants {
        static let albumLogoTopOffset = 16
        static let albumLogoLeadingOffset = 25
        static let albumLogoSize = 110
        
        static let stackViewTopOffset = 16
        static let stackViewLeadingOffset = 21
        
        static let collectionViewTopOffset = 20
        static let collectionViewHorizontalOffset = 20
        static let collectionViewBottomOffset = 10
        
        static let albumNameLabelFont = 20
        static let artistNameFont = 18
        static let releaseDateFont = 16
        static let trackCountFont = 16
        
    }
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.albumNameLabelFont))
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.artistNameFont))
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.releaseDateFont))
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.trackCountFont))
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SongsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private var stackView = UIStackView()
    var album: Album?
    private var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegate()
        setModel()
        fetchSongs(album: album)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(albumLogo)
        
        stackView = UIStackView(arrangedSubviews: [albumNameLabel,
                                                   artistNameLabel,
                                                   releaseDateLabel,
                                                   trackCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        
        view.addSubview(stackView)
        view.addSubview(collectionView)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setModel() {
        guard let album = album else { return }
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
        releaseDateLabel.text = setDateFormat(date: album.releaseDate)
        
        guard let url = album.artworkUrl100 else { return }
        setImage(urlString: url)
        
    }
    
    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    private func setImage(urlString: String?) {
        
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url) { [weak self] result in
                switch result {
                    case .success(let data):
                        let image = UIImage(data: data)
                        self?.albumLogo.image = image
                    case .failure(let error):
                        self?.albumLogo.image = nil
                        print("No album logo" + error.localizedDescription)
                }
            }
        } else {
            albumLogo.image = nil
        }
    }
    
    private func fetchSongs(album: Album?) {
        
        guard let album = album else { return }
        
        let idAlbum = album.collectionId
        print(idAlbum)
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel else { return }
                self?.songs = songModel.results
                self?.collectionView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
//MARK: - CollectionView Delegate
extension DetailAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SongsCollectionViewCell
        let song = songs[indexPath.row].trackName
        cell.nameSongLabel.text = song
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: 20
        )
    }
}

//MARK: - SetConstraints

private extension DetailAlbumViewController {
    
    func setConstraints() {
        
        albumLogo.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.albumLogoTopOffset)
            make.leading.equalTo(self.view.snp.leading).offset(Constants.albumLogoLeadingOffset)
            make.height.equalTo(Constants.albumLogoSize)
            make.width.equalTo(Constants.albumLogoSize)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.stackViewTopOffset)
            make.leading.equalTo(albumLogo.snp.trailing).offset(Constants.stackViewLeadingOffset)
            make.trailing.equalTo(self.view.snp.trailing).offset(-Constants.stackViewLeadingOffset)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(albumLogo.snp.bottom).offset(Constants.collectionViewTopOffset)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(Constants.collectionViewHorizontalOffset)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-Constants.collectionViewHorizontalOffset)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-Constants.collectionViewBottomOffset)
        }
    }
}
