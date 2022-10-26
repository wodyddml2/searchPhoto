//
//  PhotoCollectionViewCell.swift
//  searchPhoto
//
//  Created by J on 2022/10/24.
//

import UIKit

import SnapKit

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
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
        view.font = .boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [photoImageView, photoTitleLabel].forEach {
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
            make.centerY.equalTo(self)
            make.leading.equalTo(photoImageView.snp.trailing).offset(4)
            make.trailing.lessThanOrEqualTo(-8)
        }  
    }
}
