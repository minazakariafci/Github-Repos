//
//  Repository.swift
//  iOS Task
//
//  Created by mac on 6/1/21.
//

import Foundation
import RxCocoa
import RxSwift

class Repository{
    func getData()  -> Observable<[RepositoryModel]> {
        return Observable.create { observer -> Disposable in
            if let repoList = CoreDataManger.shared.getRepos(), !repoList.isEmpty{
                observer.onNext(repoList)
            }
            else{
                APIClient.instance.getData(url: "https://api.github.com/users/johnsundell/repos") {(data: [RepositoryModel]?, error) in
                    if let error = error {
                        observer.onError(error)
                    }else{
                        guard let data = data else { return  }
                        observer.onNext(data)
                        CoreDataManger.shared.removeAllItems()
                        CoreDataManger.shared.addRepo(repos: data)
                    }
                }
            }
            return Disposables.create()
        }
    }
}

