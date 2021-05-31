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
    
    private var lastIndex = 9
    private var pageSize = 10
    var repos = [GitHupModel]()
//    var reposCoreData = [RepositryCoreData]()
    private var githupModelSubject = PublishSubject<[GitHupModel]>()
    var githupModelObservable: Observable<[GitHupModel]> {
        return githupModelSubject
    }
    
    func getData() {
        if let repoList = CoreDataManger.shared.getRepos(), !repos.isEmpty{
            self.repos = repoList
            self.githupModelSubject.onNext(Array(self.repos.prefix(self.pageSize)))
        }
        else{
            APIClient.instance.getData(url: "https://api.github.com/users/johnsundell/repos") { [weak self] (data: [GitHupModel]?, error) in
                if let error = error {
                    print(error)
                }else{
                    guard let data = data else { return  }
                    self?.repos = data
                    //                let self?.repos.
                    self?.githupModelSubject.onNext(Array(self!.repos.prefix(self!.pageSize)))
                                    CoreDataManger.shared.removeAllItems()
                                    CoreDataManger.shared.addRepo(repos: data)
                }
            }
        }
    
    
    }
    
    func loadMore() {
       print(lastIndex)
        if self.repos.count > lastIndex + pageSize{
            githupModelSubject.onNext(Array(repos[lastIndex ... lastIndex + pageSize ]))
            lastIndex = lastIndex + pageSize
        }
        else {
            githupModelSubject.onNext(Array(repos[lastIndex ... repos.count - 1]))
            
            githupModelSubject.onCompleted()
            githupModelSubject.dispose()
        }

      
    }
}
