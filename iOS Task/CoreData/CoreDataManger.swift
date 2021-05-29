//
//  CoreDataManger.swift
//  iOS Task
//
//  Created by mac on 5/29/21.
//

import CoreData

class CoreDataManger{
    
    public static let shared: CoreDataManger = CoreDataManger()
    
    private init(){}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOS_Task")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context : NSManagedObjectContext!{
        return persistentContainer.viewContext
    }
    
    //MARK:- Save CoreData
    private func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }
            catch let error{
                print("Can't save context:",error)
            }
        }
    }
    
    func delete(_ obj: [NSManagedObject]?) {
        guard let deleteObjc = obj else { return }
        deleteObjc.forEach({context.delete($0)})
        print("Deleted Succesed")
        saveContext()
    }
    
    //MARK:- Add Repo
    func addRepo(repos: [GitHupModel]){
        for repo in repos{
            let repoCD: RepositryCoreData! = NSEntityDescription.insertNewObject(forEntityName: "RepositryCoreData", into: context) as? RepositryCoreData
            if let repoName = repo.name{
                repoCD.name = repoName
            }
            
            if let repoDesc = repo.description{
                repoCD.descriptionOfRepositry = repoDesc
            }
            
            if let repoForksCount = repo.forksCount{
                repoCD.forksCount = Int16(repoForksCount)
            }
            
            if let repoLan = repo.language{
                repoCD.language = repoLan
            }
            
            if let repoDate = repo.createdAt{
                repoCD.creationDate = repoDate
            }
            
            if let repoImage = repo.owner?.avatarUrl{
                repoCD.image = repoImage
            }
            
            if let repoURL = repo.htmlURL{
                repoCD.repoURL = repoURL
            }
            saveContext()
        }
    }
    
    //    //MARK:- Get Repos
    func getRepos()->([GitHupModel]?){
        do{
            if let reposCD = try context.fetch(RepositryCoreData.fetchRequest()) as? [RepositryCoreData]{
                var repos: [GitHupModel] = []
                for repo in reposCD{
                    let repo = GitHupModel(name: repo.name, owner: Owner(avatarUrl: repo.image), description: repo.descriptionOfRepositry, createdAt: repo.creationDate, language: repo.language, forksCount: Int(repo.forksCount),htmlURL: repo.repoURL)
                    repos.append(repo)
                }
                return (repos)
            }
            return (nil)
        }
        catch let error{
            
            print("Can't Get Repos",error)
            return (nil)
        }
    }
    
    //MARK:- Delete Items From CoreData
    func removeAllItems(){
        do{
            let items = try context.fetch(RepositryCoreData.fetchRequest()) as! [RepositryCoreData]
            delete(items)
        }
        catch let err {
            print("Error on creating/updating order", err)
            return
        }
    }
    
}
