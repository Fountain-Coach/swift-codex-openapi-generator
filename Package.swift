// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SwiftCodexOpenAPIGenerator",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "generator", targets: ["GeneratorCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", exact: "4.115.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "Generator",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Yams", package: "Yams")
            ],
            path: "Sources/Generator"
        ),
        .executableTarget(
            name: "GeneratorCLI",
            dependencies: ["Generator"],
            path: "Sources/GeneratorCLI"
        ),
        .testTarget(
            name: "GeneratorTests",
            dependencies: ["Generator"],
            path: "Tests/GeneratorTests",
            resources: [.copy("Fixtures")]
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
