//
//  CleanArchitectureWithMVVMApp.swift
//  CleanArchitectureWithMVVM
//
//  Created by tigi KIM on 2021/01/18.
//

import SwiftUI
import PresentationLayer

@main
struct CleanArchitectureWithMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            GroupView(viewModel: AppDI.shared.myGroupListDependencies())
        }
    }
}
