// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LogKit",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LogKit",
            targets: ["LogKit"]),
        
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LogKit",
            dependencies: []),
        .testTarget(
            name: "LogKitTests",
            dependencies: ["LogKit"]),
    ]
)
