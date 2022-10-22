//
//  ViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

class PhotoListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "검색", style: .plain, target: self, action: #selector(searchButtonTapped))
    }

    @objc func searchButtonTapped() {
        let vc = SearchPhotoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

