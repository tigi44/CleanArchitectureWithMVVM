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
        // Dependency Inversion : UseCase(DomainLayer) <- Repository <-> DataSource
        .target(
            name: "DataLayer",
            dependencies: ["DomainLayer"]),
        
        //MARK: - Domain Layer
        .target(
            name: "DomainLayer",
            dependencies: []),
        
        //MARK: - Presentation Layer (MVVM)
        // Dependency : View -> ViewModel -> Model(DomainLayer)
        .target(
            name: "PresentationLayer",
            dependencies: ["DomainLayer"]),
        
        
        //MARK: - Tests
        .testTarget(
            name: "DataLayerTests",
            dependencies: ["DataLayer"]),
            
        .testTarget(
            name: "DomainLayerTests",
            dependencies: ["DomainLayer"]),
        
        .testTarget(
            name: "PresentationLayerTests",
            dependencies: ["PresentationLayer"]),
    ]
)
