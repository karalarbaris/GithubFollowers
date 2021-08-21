//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 20.08.2021.
//

import UIKit

class UserInfoVC: UIViewController {

    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        getUserInfo(username: username)

    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func getUserInfo(username: String) {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                self.presentBKAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okaay")
            }
        }
        
    }

}
