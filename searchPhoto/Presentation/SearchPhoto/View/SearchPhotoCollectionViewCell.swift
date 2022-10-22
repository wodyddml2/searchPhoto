//
//  SearchPhotoCollectionViewCell.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

import SnapKit

class SearchPhotoCollectionViewCell: BaseCollectionViewCell {
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let photoTitleLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let photoLikeLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let photoDownloadLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    let photoLikeImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    let photoDownloadImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [photoImageView, photoTitleLabel, photoLikeImageView, photoLikeLabel, photoDownloadImageView, photoDownloadLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
    }
    
    
    
}
