//
//  RepositoryViewModel.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import Foundation
import RxCocoa
import RxSwift
import CoreData

class RepositoryViewModel {
    
    private var lastIndex = 9
    private var pageSize = 10
    var repos = [RepositoryModel]()
    private var repositoryModelSubject = PublishSubject<[RepositoryModel]>()
    var repositoryModelObservable: Observable<[RepositoryModel]> {
        return repositoryModelSubject
    }
    
    func getData() {
        if let repoList = CoreDataManger.shared.getRepos(), !repoList.isEmpty{
            self.repos = repoList
            self.repositoryModelSubject.onNext(Array(self.repos.prefix(self.pageSize)))
        }
        else{
            APIClient.instance.getData(url: "https://api.github.com/users/johnsundell/repos") { [weak self] (data: [RepositoryModel]?, error) in
                if let error = error {
                    print(error)
                }else{
                    guard let data = data else { return  }
                    self?.repos = data
                    //                let self?.repos.
                    self?.repositoryModelSubject.onNext(Array(self!.repos.prefix(self!.pageSize)))
                    CoreDataManger.shared.removeAllItems()
                    CoreDataManger.shared.addRepo(repos: data)
                    
                    //                if let repo = CoreDataManger.shared.getRepos{
                    //                    self?.repositoryModelSubject.onNext(Array(self!.repos.prefix(self!.pageSize)))
                    //                }
                }
            }
        }
    }
    
    func loadMore() {
        print(lastIndex)
        if self.repos.count > lastIndex + pageSize{
            repositoryModelSubject.onNext(Array(repos[lastIndex + 1 ... lastIndex + pageSize ]))
            lastIndex = lastIndex + pageSize
        }
        else {
            repositoryModelSubject.onNext(Array(repos[lastIndex + 1 ... repos.count - 1]))
            repositoryModelSubject.onCompleted()
            repositoryModelSubject.dispose()
        }
    }
}
