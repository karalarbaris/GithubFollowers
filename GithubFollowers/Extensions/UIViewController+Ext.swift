//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 9.08.2021.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentBKAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = BKAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
    
}
