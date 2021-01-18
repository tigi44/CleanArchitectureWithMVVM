//
//  FetchGroupListUseCase.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import Combine

public protocol FetchMyGroupListUseCaseInterface {
    func execute(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable?
}

public final class FetchMyGroupListUseCase: FetchMyGroupListUseCaseInterface {

    private let groupRepository: GroupRepositoryInterface

    public init(groupRepository: GroupRepositoryInterface) {
        self.groupRepository = groupRepository
    }

    public func execute(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable? {
        return groupRepository.fetchMyGroupList { result in
            completion(result)
        }
    }
}

public protocol GroupRepositoryInterface {
    func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable?
}
