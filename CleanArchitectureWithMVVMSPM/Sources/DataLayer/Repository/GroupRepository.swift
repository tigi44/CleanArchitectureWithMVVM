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
            switch result {
            case .success(let myGroupModels):
                var myGroupEntities = [MyGroupEntity]()
                for myGroupModel in myGroupModels {
                    myGroupEntities.append(myGroupModel.dotMyGroupEntity())
                }
                completion(.success(myGroupEntities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
