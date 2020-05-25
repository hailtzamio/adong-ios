//
//  APIRouter.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case login(email:String, password:String)
    case getPermissions
    case getLorries
    case getLorry(id: Int)
    case updateLorry(data: Lorry)
        case removeLorry(id: Int)
    
    case getProducts(page:Int,name:String)
    case getProduct(id: Int)
    case removeProduct(id: Int)
    
    case getWorkers(page:Int,name:String)
    case getWorker(id: Int)
    case removeWorker(id: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .updateLorry :
            return .put
        case .removeProduct, .removeWorker,.removeLorry :
            return .delete
        case .getPermissions, .getLorries, .getLorry,
             .getProducts, .getProduct,
             .getWorkers, .getWorker
            :
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "login"
        case .getPermissions:
            return "myPermissions"
        case .getLorries:
            return "lorry"
        case .getLorry(let id):
            return "lorry/\(id)"
        case .updateLorry(let data):
            let id = data.id ?? 0
            return "lorry/\(id)"
            case .removeLorry(let id):
                return "lorry/\(id)"
        case .getProducts(let page, let name):
            return "product?page=0"
        case .getProduct(let id) :
            return "product/\(id)"
        case .removeProduct(let id):
            return "product/\(id)"
            
        case .getWorkers:
            return "worker"
        case .getWorker(let id):
            return "worker/\(id)"
        case .removeWorker(let id):
            return "worker/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [APIParameterKey.email: email, APIParameterKey.password: password]
        case .updateLorry(let data):
            return ["brand": data.brand, "model": data.model,"plateNumber": data.plateNumber, "capacity": data.capacity]
        case .getPermissions, .getLorries, .getLorry, .removeLorry,       .getProducts, .getProduct, .removeProduct,
             .getWorkers, .getWorker, .removeWorker:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        print(urlRequest)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.token.rawValue,forHTTPHeaderField: "Authorization")
        
        //        URLEncoding.default
        
        // Parameters
        if(method.rawValue == "POST" || method.rawValue == "PUT" ) {
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        } else {
            if let parameters = parameters {
                do {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                } catch {
                    print("Encoding fail")
                }
            }
        }
        
        return urlRequest
    }
}

