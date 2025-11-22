//
//  TempAPI.swift
//  CMC-UMC-R
//
//  Created by 이인호 on 11/22/25.
//

import Foundation

final class TempAPI {
    let baseURL: String = "https://api.com"
    
//    func fetchData() -> AnyPublisher<[Model], Never> {
//        let url = URL(string: "\(baseURL)/ex")!
//        
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .handleEvents(receiveCompletion: {
//                print($0)
//            })
//            .decode(type: [Model].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//    }
//    
//    func postData(payload: Model) -> AnyPublisher<Bool, Never> {
//        let url = URL(string: "\(baseURL)/ex")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        request.httpBody = try? JSONEncoder().encode(payload)
//        
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: Model.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//    
//    func updateData(id: String, payload: Model) -> AnyPublisher<Model, Error> {
//        let url = URL(string: "\(baseURL)/ex/\(id)")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT" // or "PATCH"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONEncoder().encode(payload)
//        
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map(\.data)
//            .decode(type: Model.self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
//
//    func deleteData(id: String) -> AnyPublisher<Bool, Never> {
//        let url = URL(string: "\(baseURL)/ex/\(id)")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .map { _ in true }
//            .replaceError(with: false)
//            .eraseToAnyPublisher()
//    }
}
