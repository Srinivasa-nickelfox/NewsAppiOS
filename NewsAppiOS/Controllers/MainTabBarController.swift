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
        
        // Initializing HomeViewController and SearchViewController as rootViewControllers for MainTabBarController
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        
        setViewControllers([vc1, vc2], animated: true)
    }

}
