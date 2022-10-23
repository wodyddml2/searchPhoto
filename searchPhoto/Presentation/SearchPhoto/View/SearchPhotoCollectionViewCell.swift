//
//  SearchPhotoCollectionViewCell.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit

final class SearchPhotoCollectionViewCell: BaseCollectionViewCell {
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = .red
        return view
    }()
    
    let photoTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 18)
        view.text = "NON"
        view.numberOfLines = 2
        return view
    }()
    
    let photoLikeLabel: UILabel = {
        let view = UILabel()
        view.text = "aaaa"
        return view
    }()
    
    let photoUpdateLabel: UILabel = {
        let view = UILabel()
        view.text = "Ssss"
        return view
    }()
    
    let photoLikeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart.fill")
        view.tintColor = .red
        return view
    }()
    
    let photoUpdateImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.down.app")
        view.tintColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [photoImageView, photoTitleLabel, photoLikeImageView, photoLikeLabel, photoUpdateImageView, photoUpdateLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        
        photoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.top).offset(4)
            make.leading.equalTo(photoImageView.snp.trailing).offset(4)
            make.trailing.lessThanOrEqualTo(-8)
        }
        
        photoLikeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(photoImageView.snp.trailing).offset(4)
            make.bottom.equalTo(photoUpdateImageView.snp.top).offset(-6)
        }
        
        photoLikeLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoLikeImageView.snp.trailing).offset(6)
            make.centerY.equalTo(photoLikeImageView)
            make.trailing.lessThanOrEqualTo(-8)
        }
        
        photoUpdateImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.leading.equalTo(photoImageView.snp.trailing).offset(4)
            make.bottom.equalTo(photoImageView.snp.bottom).offset(-4)
        }
        
        photoUpdateLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoUpdateImageView.snp.trailing).offset(6)
            make.centerY.equalTo(photoUpdateImageView)
            make.trailing.lessThanOrEqualTo(-8)
        }
    }
    
    
    
}
