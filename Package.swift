// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftCodexOpenAPIGenerator",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "generator", targets: ["Generator"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", exact: "4.115.0")
    ],
    targets: [
        .executableTarget(
            name: "Generator",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ],
            path: "Sources/Generator"
        ),
        .testTarget(
            name: "GeneratorTests",
            dependencies: ["Generator"],
            path: "Tests/GeneratorTests"
        ),
        .testTarget(
            name: "ServerTests",
            dependencies: [
                "Generator",
                .product(name: "XCTVapor", package: "vapor")
            ],
            path: "Tests/ServerTests"
        )
    ]
)
