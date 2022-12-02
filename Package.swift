// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iOS-SDK",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "iOS-SDK",
            targets: ["iOS-SDK"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/jrendel/SwiftKeychainWrapper.git", branch: "develop"),
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.18.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/juozasvalancius/SwiftLint/releases/download/spm-accommodation/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "cdc36c26225fba80efc3ac2e67c2e3c3f54937145869ea5dbcaa234e57fc3724"
        ),
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .target(
            name: "iOS-SDK",
            dependencies: [
                .product(name: "ReactiveMoya", package: "Moya"),
                "SwiftLintPlugin",
                "SwiftKeychainWrapper",
                "PromiseKit"
            ]
        ),
        .testTarget(
            name: "iOS-SDKTests",
            dependencies: ["iOS-SDK"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
