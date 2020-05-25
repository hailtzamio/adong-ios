//
//  APIClient.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:ApiRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                completion(response.result)
                print(response.response?.statusCode)
                print(response.result)
        }
    }
    
    static func login(email: String, password: String, completion:@escaping (Result<User, AFError>)->Void) {
        performRequest(route: ApiRouter.login(email: email, password: password), completion: completion)
    }
    
    static func getPermissions(completion:@escaping (Result<BaseResponseList<Permission>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getPermissions, decoder: jsonDecoder, completion: completion)
    }
    
    // Lorry
    static func getLorries(completion:@escaping (Result<BaseResponseList<Lorry>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getLorries, decoder: jsonDecoder, completion: completion)
    }
    
    static func getLorry(id:Int,completion:@escaping (Result<BaseResponse<Lorry>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getLorry(id: id), decoder: jsonDecoder, completion: completion)
    }
    
    static func updateLorry(data:Lorry,completion:@escaping (Result<ResponseDefault, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.updateLorry(data: data), decoder: jsonDecoder, completion: completion)
    }
    
    static func removeLorry(id:Int,completion:@escaping (Result<ResponseDefault, AFError>)->Void) {
           let jsonDecoder = JSONDecoder()
           jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
           performRequest(route: ApiRouter.removeLorry(id: id), decoder: jsonDecoder, completion: completion)
       }
    
    // Product
    static func getProducts(page : Int, name : String,completion:@escaping (Result<BaseResponseList<Product>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getProducts(page: page, name: name), decoder: jsonDecoder, completion: completion)
    }
    
    static func getProduct(id:Int,completion:@escaping (Result<BaseResponse<Product>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getProduct(id: id), decoder: jsonDecoder, completion: completion)
    }
    
    static func removeProduct(id:Int,completion:@escaping (Result<ResponseDefault, AFError>)->Void) {
          let jsonDecoder = JSONDecoder()
          jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
          performRequest(route: ApiRouter.removeProduct(id: id), decoder: jsonDecoder, completion: completion)
      }
    
    // Worker
    static func getWorkers(page : Int, name : String,completion:@escaping (Result<BaseResponseList<Worker>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getWorkers(page: page, name: name), decoder: jsonDecoder, completion: completion)
    }
    
    static func getWorker(id:Int,completion:@escaping (Result<BaseResponse<Worker>, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.getWorker(id: id), decoder: jsonDecoder, completion: completion)
    }
    
    static func removeWorker(id:Int,completion:@escaping (Result<ResponseDefault, AFError>)->Void) {
          let jsonDecoder = JSONDecoder()
          jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
          performRequest(route: ApiRouter.removeWorker(id: id), decoder: jsonDecoder, completion: completion)
      }
}

