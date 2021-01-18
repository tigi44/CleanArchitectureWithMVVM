// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleanArchitectureWithMVVMSPM",
    platforms: [.iOS(.v14), .macOS("10.15")],
    products: [
        .library(
            name: "CleanArchitectureWithMVVMSPM",
            targets: ["View", "ViewModel", "Model", "UseCase", "Repository", "DataSource"]),
    ],
    dependencies: [
    ],
    targets: [
        
        //MARK: - Data Layer
        // Dependency Inversion : UseCase <- Repository <- DataSource
        .target(
            name: "DataSource",
            dependencies: ["Model"],
            path: "Sources/DataSource"),
        .target(
            name: "Repository",
            dependencies: ["DataSource", "Model"],
            path: "Sources/Repository"),
        
        //MARK: - Domain Layer
        .target(
            name: "UseCase",
            dependencies: ["Repository", "Model"],
            path: "Sources/UseCase"),
        .target(
            name: "Model",
            dependencies: [],
            path: "Sources/Model"),
        
        //MARK: - Presentation Layer (MVVM)
        // Dependency : View -> ViewModel -> Model & UseCase
        .target(
            name: "ViewModel",
            dependencies: ["UseCase", "Model"],
            path: "Sources/ViewModel"),
        .target(
            name: "View",
            dependencies: ["ViewModel", "Model"],
            path: "Sources/View"),
        
        
//        .testTarget(
//            name: "CleanArchitectureWithMVVMSPMTests",
//            dependencies: ["CleanArchitectureWithMVVMSPM"]),
    ]
)
