//
//  UITableViewController+SpinnerLast.swift
//  RickAndMorty
//
//  Created by Carlos Mendoza on 13/02/24.
//

import UIKit
extension UITableViewController {
    func addSpinnerLastCell (){
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: CGFloat(ViewValues.defaultHeightCell))
        tableView.tableFooterView = spinner
    }
}
