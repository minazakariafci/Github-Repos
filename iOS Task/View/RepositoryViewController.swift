//
//  RepositoryViewController.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var repositoryTableView: UITableView!
    
    let viewModel = RepositoryViewModel()
    let disposeBag = DisposeBag()
    var repos = [RepositoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.subscribeToResponse()
        self.getData()
    }
    func setupTableView() {
        repositoryTableView.registerNib(cell: RepositoryTableViewCell.self)
    }
    func getData()  {
        viewModel.getData()
    }
    func subscribeToResponse() {
        self.viewModel.repositoryModelObservable
            .subscribe(onNext: {
                self.repos.append(contentsOf: $0)
                self.repositoryTableView.reloadData()
            })
            
            .disposed(by: disposeBag)
    }
    
}

extension RepositoryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (repos.count - 1) && repos.count < viewModel.repos.count {
            viewModel.loadMore()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: repos[indexPath.row].htmlURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

extension RepositoryViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = repositoryTableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell" , for: indexPath) as! RepositoryTableViewCell
        cell.setData(repos: repos[indexPath.row])
        return cell
    }
}
