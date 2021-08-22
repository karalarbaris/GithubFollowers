//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 20.08.2021.
//

import UIKit

class UserInfoVC: UIViewController {

    let headerView = UIView()
    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        layoutUI()

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
                DispatchQueue.main.async {
                    self.add(childVC: BKUserInfoHeaderVC(user: user), to: self.headerView)
                }
                
            case .failure(let error):
                self.presentBKAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okaay")
            }
        }
        
    }
    
    
    private func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)

        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
}
