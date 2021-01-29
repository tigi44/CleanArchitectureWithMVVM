//
//  GroupEntity.swift
//  
//
//  Created by tigi KIM on 2021/01/18.
//

import Foundation

public struct MyGroupEntity: Identifiable {
    public let id: String
    public let image: String
    public let name: String
    public let date: String
    
    public init(id: String, image: String, name: String, date: String) {
        self.id = id
        self.image = image
        self.name = name
        self.date = date
    }
}
