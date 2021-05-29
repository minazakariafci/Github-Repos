//
//  Extensions+UITableView.swift
//  iOS Task
//
//  Created by mac on 5/29/21.
//

import UIKit

extension UITableView{
    func registerNib<cell: UITableViewCell>(cell: cell.Type){
        register(UINib(nibName:String(describing: cell) , bundle: nil), forCellReuseIdentifier: String(describing: cell))
    }
}
