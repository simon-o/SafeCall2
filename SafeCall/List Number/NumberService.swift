//
//  NumberService.swift
//  SafeCall
//
//  Created by Antoine Simon on 20/10/2020.
//

import Foundation
import Combine

protocol NumberServiceProtocol {
    func fetchNumbersList(file: String, subject: PassthroughSubject<[Numbers], Never>)
}

final class NumberService {
    
}

extension NumberService: NumberServiceProtocol {
    func fetchNumbersList(file: String, subject: PassthroughSubject<[Numbers], Never>) {
        
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data.init(contentsOf: URL(fileURLWithPath: path))
                let jsonData = try JSONDecoder().decode([Numbers].self, from: data)
                _ = Just(jsonData).subscribe(subject)
            } catch {
                fatalError("Error: Parsing the local JSON fail, a modification have been made on the file.")
            }
        }
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
