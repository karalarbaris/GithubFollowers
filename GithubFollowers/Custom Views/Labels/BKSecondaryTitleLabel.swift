//
//  BKSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 21.08.2021.
//

import UIKit

class BKSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
        
    }
    
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
