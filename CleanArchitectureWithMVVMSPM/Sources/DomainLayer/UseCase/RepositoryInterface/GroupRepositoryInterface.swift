//
//  GroupRepositoryInterface.swift
//  
//
//  Created by tigi on 2021/01/29.
//

import Foundation
import Combine

public protocol GroupRepositoryInterface {
    func fetchMyGroupList(completion: @escaping (Result<[MyGroupEntity], Error>) -> Void) -> Cancellable?
}
