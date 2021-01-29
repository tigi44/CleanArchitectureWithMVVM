//
//  MyGroupListViewModel.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import Combine
import DomainLayer

public protocol MyGroupListViewModelInput {
    func executeFetch()
}

public protocol MyGroupListViewModelOutput {
    var myGroups: [MyGroupEntity] { get }
}

public final class MyGroupListViewModel: ObservableObject, MyGroupListViewModelInput, MyGroupListViewModelOutput {
    
    private let fetchMyGroupListUseCase: FetchMyGroupListUseCaseInterface
    
    @Published public var myGroups: [MyGroupEntity] = []
    
    public init(fetchMyGroupListUseCase: FetchMyGroupListUseCaseInterface) {
        self.fetchMyGroupListUseCase = fetchMyGroupListUseCase
    }
    
    public func executeFetch() {
        var _ = fetchMyGroupListUseCase.execute { result in
            switch result {
            case .success(let myGroups):
                self.myGroups = myGroups
            case .failure:
                self.myGroups = []
            }
        }
    }
}
