//
//  MyGroupDI.swift
//  CleanArchitectureWithMVVM
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import DataLayer
import DomainLayer
import PresentationLayer

public class MyGroupDI {
    
    private let appEnvironment: AppEnvironment
    
    public init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    public func myGroupListDependencies() -> MyGroupListViewModel {
        
        //MARK: Data Layer
        let groupDS: GroupDataSourceInterface
        
        switch appEnvironment.phase {
        case .DEV:
            groupDS = GroupLocalDataSource()
        default:
            groupDS = GroupRemoteDataSource(urlString: "")
        }
        
        let groupRepo = GroupRepository(groupDataSource: groupDS)
        
        //MARK: Domain Layer
        let fetchMyGroupListUseCase = FetchMyGroupListUseCase(groupRepository: groupRepo)
        
        //MARK: Presentation
        let myGroupListViewModel = MyGroupListViewModel(fetchMyGroupListUseCase: fetchMyGroupListUseCase)
        
        return myGroupListViewModel
    }
}
