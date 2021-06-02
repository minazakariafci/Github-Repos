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
    func numberOfRows(in section :Int = 0)->Int{
        self.numberOfRows(inSection: section)
    }
    func getCellAt(indexPath :IndexPath)->RepositoryTableViewCell{
        if let cell = self.dataSource?.tableView(self, cellForRowAt: indexPath){
            return cell as! RepositoryTableViewCell
        }
        return RepositoryTableViewCell()
    }
}


