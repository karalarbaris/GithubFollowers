//
//  BKRepoItemVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 24.08.2021.
//

import UIKit

class BKRepoItemVC: BKItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
 
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
