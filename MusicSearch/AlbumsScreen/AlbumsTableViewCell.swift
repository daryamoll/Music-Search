
import UIKit

class AlbumsTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let albumLogoLeadingOffset = 15
        static let albumLogoSize = 60
        
        static let albumNameLabelTopOffset = 5
        static let albumNameLabelLeadingOffset = 18
        static let albumNameLabelTrailingOffset = 100
        
        static let trackCountLabelTopOffset = 18
        static let trackCountLabelLeadingOffset = 10
        static let trackCountLabelTrailingOffset = 15
    }
    
    private let albumLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    var stackView = UIStackView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumLogo.layer.cornerRadius = albumLogo.frame.width / 2
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(albumLogo)
        
        stackView = UIStackView(arrangedSubviews: [albumNameLabel, artistNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        self.addSubview(stackView)
        
        self.addSubview(trackCountLabel)
    }
    
    func configureAlbumCell(album: Album) {
        
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
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
        
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    private func setConstraints() {
        albumLogo.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(Constants.albumLogoLeadingOffset)
            make.height.equalTo(Constants.albumLogoSize)
            make.width.equalTo(Constants.albumLogoSize)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.albumNameLabelTopOffset)
            make.leading.equalTo(albumLogo.snp.trailing).offset(Constants.albumNameLabelLeadingOffset)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.albumNameLabelTrailingOffset)
        }
        
        trackCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.trackCountLabelTopOffset)
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(stackView.snp.trailing).offset(Constants.trackCountLabelLeadingOffset)
            make.trailing.equalTo(self.snp.trailing).offset(Constants.trackCountLabelTrailingOffset)
        }
    }
}
