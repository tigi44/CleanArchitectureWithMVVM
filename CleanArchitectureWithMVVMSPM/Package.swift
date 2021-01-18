// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleanArchitectureWithMVVMSPM",
    platforms: [.iOS(.v14), .macOS("10.15")],
    products: [
        .library(
            name: "CleanArchitectureWithMVVMSPM",
            targets: ["DataLayer", "DomainLayer", "PresentationLayer"]),
        
    ],
    dependencies: [
    ],
    targets: [
        
        //MARK: - Data Layer
        // Dependency Inversion : UseCase <- Repository <- DataSource
        .target(
            name: "DataLayer",
            dependencies: ["DomainLayer"]),
        
        //MARK: - Domain Layer
        .target(
            name: "DomainLayer",
            dependencies: []),
        
        //MARK: - Presentation Layer (MVVM)
        // Dependency : View -> ViewModel -> Model & UseCase
        .target(
            name: "PresentationLayer",
            dependencies: ["DomainLayer"]),
        
        
//        .testTarget(
//            name: "CleanArchitectureWithMVVMSPMTests",
//            dependencies: ["CleanArchitectureWithMVVMSPM"]),
    ]
)
