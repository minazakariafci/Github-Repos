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
    var repos = [GitHupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.subscribeToResponse()
        self.getData()
    }
    
    func setupTableView() {
        githupTableView.registerNib(cell: GitHupTableViewCell.self)
    }
    
    func getData()  {
        githupView.getData()
    }
    
    
    func subscribeToResponse() {
        self.githupView.githupModelObservable
            .subscribe(onNext: {
              self.repos.append(contentsOf: $0)
                self.githupTableView.reloadData()
            })
            
            .disposed(by: disposeBag)
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (repos.count - 1) && repos.count < githupView.repos.count {
            githupView.loadMore()
        }
    }
}

extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = githupTableView.dequeueReusableCell(withIdentifier: "GitHupTableViewCell" , for: indexPath) as! GitHupTableViewCell
        cell.setData(repos: repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: repos[indexPath.row].htmlURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
}
