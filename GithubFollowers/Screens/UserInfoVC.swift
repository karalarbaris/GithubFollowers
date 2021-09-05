//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 20.08.2021.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: BKDataloadingVC {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = BKBodyLabel(textAlignment: .center)
    
    var itemViews : [UIView] = []
    
    var username : String!
    
    weak var delegate : UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        layoutUI()
        getUserInfo(username: username)
        
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo(username: String) {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentBKAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okaay")
            }
        }
        
    }
    
    
    func configureUIElements(with user: User) {
        
        let repoItemVC = BKRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = BKFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: BKUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    private func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        let padding : CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
        }


        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UserInfoVC: BKItemInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        // Show safari view controller
        
        guard let url = URL(string: user.htmlUrl) else {
            presentBKAlertOnMainThread(title: "Invalid url", message: "invalid", buttonTitle: "Okay")
            return
        }
        
        presentSafariVC(with: url)
        
    }
    
    func didTapGetFollowers(for user: User) {
        // dismiss vc
        
        // Tell follower list screen the new user
        
        guard user.followers != 0 else {
            presentBKAlertOnMainThread(title: "No followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
}
