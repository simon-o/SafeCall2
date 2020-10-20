//
//  NumberService.swift
//  SafeCall
//
//  Created by Antoine Simon on 20/10/2020.
//

import Foundation
import Combine

protocol NumberServiceProtocol {
    func fetchNumbersList(file: String, suscriber: PassthroughSubject<[Numbers], Error>) -> AnyPublisher<[Numbers], Error>
}

final class NumberService {
    
}

extension NumberService: NumberServiceProtocol {
    func fetchNumbersList(file: String, suscriber: PassthroughSubject<[Numbers], Error>) -> AnyPublisher<[Numbers], Error> {
        DispatchQueue.global().async {
            if let path = Bundle.main.path(forResource: file, ofType: "json") {
                do {
                    let data = try Data.init(contentsOf: URL(fileURLWithPath: path))
                    let jsonData = try JSONDecoder().decode([Numbers].self, from: data)
                    suscriber.send(jsonData)
                } catch {
                    suscriber.send(completion: Subscribers.Completion<Error>.failure(error))
                }
            }
        }
        return suscriber.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}

struct Numbers: Codable {
    var Country: Country
    var Ambulance: Ambulance
    var Fire: Fire
    var Police: Police
}

struct Country: Codable {
    var Name: String
    var ISOCode: String
    var ISONumeric: String
}

struct Ambulance: Codable {
    var All: [String?]
}

struct Fire: Codable {
    var All: [String?]
}

struct Police: Codable {
    var All: [String?]
}
