//
//  AppDI.swift
//  CleanArchitectureWithMVVM
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation
import PresentationLayer

enum PHASE {
    case DEV, ALPHA, REAL
}

public class AppEnvironment {
    let phase: PHASE = .DEV
}

public class AppDI: AppDIInterface {
    
    static let shared = AppDI(appEnvironment: AppEnvironment())
    
    private let appEnvironment: AppEnvironment
    
    private init(appEnvironment: AppEnvironment) {
        self.appEnvironment = appEnvironment
    }
    
    public func myGroupListDependencies() -> MyGroupListViewModel {
        
        let myGroupDI: MyGroupDI = MyGroupDI(appEnvironment: appEnvironment)
                
        let myGroupListViewModel = myGroupDI.myGroupListDependencies()
                
        return myGroupListViewModel
    }
}
