//
//  GroupDataSource.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import Combine
import DomainLayer

public struct GroupModel: Codable {
    let image: String
    let name: String
    let date: String
    
    // DOT: Data Object Transfer
    public func dotMyGroupEntity() -> MyGroupEntity {
        return MyGroupEntity(id: self.name, image: self.image, name: self.name, date: self.date)
    }
}

public protocol GroupDataSourceInterface {
    func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable?
}

public final class GroupLocalDataSource: GroupDataSourceInterface {
    static var myGroups = [
        [
            "image": "group1",
            "name": "group 1",
            "date": "2020.01.01 Mon",
        ],
        [
            "image": "group2",
            "name": "group 2",
            "date": "2020.01.02 Mon",
        ],
        [
            "image": "group3",
            "name": "group 3",
            "date": "2020.01.03 Mon",
        ],
        [
            "image": "group4",
            "name": "group 4",
            "date": "2020.01.04 Mon",
        ],
        [
            "image": "group5",
            "name": "group 5",
            "date": "2020.01.05 Mon",
        ]
    ]
    
    public init() {}
    
    public func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable? {
        return Just(GroupLocalDataSource.myGroups)
            .tryMap { try JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
            .decode(type: [GroupModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .map({ $0.compactMap { $0.dotMyGroupEntity() }})
            .eraseToAnyPublisher()
            .sink { myGroups in
                completion(.success(myGroups))
            }
    }
}

public protocol GroupRemoteDataSourceInterface {
    init(urlString: String)
}

public final class GroupRemoteDataSource: GroupDataSourceInterface, GroupRemoteDataSourceInterface {
    
    let urlString: String
    
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable? {
        
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: urlString)!)
            .map(\.data)
            .decode(type: [GroupModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .map({ $0.compactMap { $0.dotMyGroupEntity() }})
            .eraseToAnyPublisher()
            .sink { myGroups in
                completion(.success(myGroups))
            }
    }
}
