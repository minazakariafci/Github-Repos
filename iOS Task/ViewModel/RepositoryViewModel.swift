//
//  RepositoryViewModel.swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import Foundation
import RxCocoa
import RxSwift

class RepositoryViewModel {
    let disposeBag = DisposeBag()
    private var lastIndex = 9
    private var pageSize = 10
    var repos = [RepositoryModel]()
    let repository = Repository()
    private var repositoryModelSubject = PublishSubject<[RepositoryModel]>()
    var repositoryModelObservable: Observable<[RepositoryModel]> {
        return repositoryModelSubject
    }
    
    func getData(){
        repository.getData().subscribe(
            onNext: { [weak self] repo in
            self?.repos = repo
            self?.repositoryModelSubject.onNext(Array(self!.repos.prefix(self!.pageSize)))
            }).disposed(by: disposeBag)
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
