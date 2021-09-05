//
//  BKItemInfoView.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 23.08.2021.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}


class BKItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel      = BKTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = BKTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = Constants.Images.repos
            titleLabel.text = "Public Repos"
        case .followers:
            symbolImageView.image = Constants.Images.followers
            titleLabel.text = "Public Gists"
        case .following:
            symbolImageView.image = Constants.Images.following
            titleLabel.text = "Following"
        case .gists:
            symbolImageView.image = Constants.Images.gists
            titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }

}
