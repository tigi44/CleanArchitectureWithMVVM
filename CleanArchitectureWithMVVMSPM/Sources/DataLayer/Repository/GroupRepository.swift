//
//  GroupRepository.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import Combine
import DomainLayer

public final class GroupRepository: GroupRepositoryInterface {
    
    private let groupDataSource: GroupDataSourceInterface
    
    public init(groupDataSource: GroupDataSourceInterface) {
        self.groupDataSource = groupDataSource
    }
    
    public func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable? {
        
        return groupDataSource.fetchMyGroupList { result in
            completion(result)
        }
    }
}
