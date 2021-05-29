//
//  ViewController.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var githupTableView: UITableView!
    
    let githupView = GithupViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.subscribeToResponse()
        self.subscribeToBranchSelection()
        self.getData()
    }
    
    func setupTableView() {
        githupTableView.registerNib(cell: GitHupTableViewCell.self)
    }
    
    func getData()  {
        githupView.getData()
    }
    
    // Set
    func subscribeToResponse() {
        self.githupView.githupModelObservable
            .bind(to: self.githupTableView
                    .rx
                    .items(cellIdentifier: String(describing: GitHupTableViewCell.self),
                           cellType: GitHupTableViewCell.self)) { row, repos, cell in
                cell.setData(repos: repos)
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeToBranchSelection() {
        Observable
            .zip(githupTableView.rx.itemSelected, githupTableView.rx.modelSelected(GitHupModel.self))
            .bind {selectedIndex, repo in
                if let url = URL(string: repo.htmlURL ?? "") {
                    UIApplication.shared.open(url)
                }
            }
            .disposed(by: disposeBag)
    }
}

