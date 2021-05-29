//
//  githupViewModel.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import Foundation
import RxCocoa
import RxSwift
import CoreData

class GithupViewModel {
    
    private var githupModelSubject = PublishSubject<[GitHupModel]>()
    var githupModelObservable: Observable<[GitHupModel]> {
        return githupModelSubject
    }
    
    func getData() {
        if let repos = CoreDataManger.shared.getRepos(), !repos.isEmpty{
            githupModelSubject.onNext(repos)
        }
        APIClient.instance.getData(url: "https://api.github.com/users/johnsundell/repos") { [weak self] (data: [GitHupModel]?, error) in
            if let error = error {
                print(error)
            }else{
                guard let data = data else { return  }
                self?.githupModelSubject.onNext(data)
                CoreDataManger.shared.removeAllItems()
                CoreDataManger.shared.addRepo(repos: data)
            }
        }
    }
}
