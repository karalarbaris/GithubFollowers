//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 8.08.2021.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
            guard let followers = followers else {
                self.presentBKAlertOnMainThread(title: "Error", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("followers.count: \(followers.count)")
            print(followers)
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
