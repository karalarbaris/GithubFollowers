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
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentBKAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okk")
            }
        
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
