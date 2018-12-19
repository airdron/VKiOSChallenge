//
//  NetworkManager.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func performRequest<T>(request: URLRequest,
                           processData: @escaping ((_ responseData: Data) throws -> T),
                           completionHandler: @escaping ((Result<T>) -> Void)) {
        self.urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(ApiError.unknownError))
                print("Not http response")
                return
            }
            let statusCode = response.statusCode
            if statusCode >= 200 && statusCode < 300 {
                do {
                    guard let data = data else {
                        completionHandler(.failure(ApiError.unknownError))
                        return
                    }
                    let entity: T = try processData(data)
                    completionHandler(.success(entity))
                } catch let error as DecodingError {
                    let debugError: Error? = error
                    print(debugError.debugDescription)
                    print(error.localizedDescription)
                    completionHandler(.failure(error))
                } catch let error as NSError {
                    completionHandler(.failure(error))
                } catch {
                    completionHandler(.failure(ApiError.unknownError))
                }
            } else {
                print(statusCode)
            }
        }.resume()
    }
}
