//
//  BaseViewController.swift
//  searchPhoto
//
//  Created by J on 2022/10/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        setConstraints()
    }
    

    func configureUI() { }
    
    func setConstraints() { }
}
