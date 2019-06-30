//
//  RequestSingleton.swift
//  F_Core_2
//
//  Created by Lloyd Dapaah on 6/30/19.
//  Copyright © 2019 LDLLC. All rights reserved.
//

import Foundation
import Alamofire

internal enum BaseURL: String {
    case setup = "https://feast-server.herokuapp.com/setup?"
    case addon = "https://feast-server.herokuapp.com/addon?"
}

fileprivate enum Parameters: String {
    case classifiers = "classifiers"
}

internal class RequestSingleton {
    
    static func fetchClassifiers(_ url: BaseURL, previous: [Classifier] = [], isNested: Bool = true, completion: @escaping (Any) -> Void) {
        var params = [Parameters.classifiers.rawValue: [""]]
        if !previous.isEmpty {
            params = [Parameters.classifiers.rawValue: previous.map {$0.name}]
        }
        
        Alamofire.request(url.rawValue, parameters: params).responseData { responseData in
            guard responseData.result.isSuccess, responseData.response?.statusCode == 200, let data = responseData.result.value else {
                print("REQUEST", responseData.request ?? "Invalid URL")
                print("ERROR", responseData.result.error ?? "Fetch Error")
                return
            }
            
            if isNested {
                completion(decodeNestedArrayClassifiers(data))
            } else {
                completion(decodeArrayClassifiers(data))
            }
        }
    }
    
    static func decodeNestedArrayClassifiers(_ data: Data) -> [[Classifier]] {
        guard let decoded = try? JSONDecoder().decode([[String]].self, from: data) else {
            print("Parsing Fail")
            return []
        }
        
        return decoded.map { (nestedArray) -> [Classifier] in
            return nestedArray.map { Classifier(name: $0) }
        }
    }
    
    static func decodeArrayClassifiers(_ data: Data) -> [Classifier] {
        guard let decoded = try? JSONDecoder().decode([String].self, from: data) else {
            print("Parsing Fail")
            return []
        }
        
        return decoded.map { Classifier(name: $0) }
    }
}
