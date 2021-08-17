//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 8.08.2021.
//

import UIKit

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }            
            self.dismissLoadingView()

            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: followers)
                self.updateData()
                
            case .failure(let error):
                self.presentBKAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Okk")
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>.init(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            //or
//            cell.usernameLabel.text = follower.login
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)

    }
    
    
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y //how far we scrolled down
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        
        print("offsetY: \(offsetY)")
        print("contentHeight: \(contentHeight)")
        print("height: \(height)")
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }

    }
    
}
