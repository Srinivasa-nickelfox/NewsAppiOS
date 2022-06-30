//
//  MaintabControllerViewController.swift
//  NewsAppiOS
//
//  Created by Midhun Kasibhatla on 29/06/22.
//

import UIKit

class MaintabControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        let vc1 = UINavigationController(rootViewController: HomeViewController())
       // let vc2 = UINavigationController(rootViewController: SearchViewController())
        
        setViewControllers([vc1], animated: true)
    }

}
