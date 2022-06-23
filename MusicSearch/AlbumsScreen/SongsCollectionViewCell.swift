
import UIKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.addSubview(nameSongLabel)
        nameSongLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
