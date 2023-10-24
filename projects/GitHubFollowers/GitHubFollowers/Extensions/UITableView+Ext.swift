//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Anvar Rahimov on 08.02.2023.
//

import UIKit

extension UITableView {
    public func removeExsessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    public func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
