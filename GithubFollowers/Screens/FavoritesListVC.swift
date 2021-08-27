//
//  FavoritesListViewController.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 5.08.2021.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let followers):
                print(followers)
                break
            case .failure(let error):
            break
            }
        }

    }

}
