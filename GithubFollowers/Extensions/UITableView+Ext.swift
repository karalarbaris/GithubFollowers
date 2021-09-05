//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 5.09.2021.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
