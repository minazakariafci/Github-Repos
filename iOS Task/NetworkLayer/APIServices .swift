//
//  APIServices .swift
//  iOS Task
//
//  Created by mac on 5/28/21.
//

import Foundation
import Alamofire

class APIClient {
    //single tone
    static let instance = APIClient()

    func getData <T:Decodable>(url: String ,id: String = "" , completion: @escaping (T?, Error?)->Void){
        let paramter = ["id": Int(id)]
        
        Alamofire.request(url ,parameters: paramter ).responseJSON { (response) in
            guard let data = response.data else {return}
            switch response.result{
            case .success(let val):
                do{
                    let sports = try JSONDecoder().decode(T.self, from: data)
                    completion(sports , nil)
                    print(url+id)
                }catch let jsonError{
                print(jsonError)
                }
            case .failure(let error):
                completion(nil,error)

            }
        }
    }
}
