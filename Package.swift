// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Markdowntown",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Markdowntown",
            targets: ["Markdowntown"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/apple/swift-markdown", branch: "release/5.6"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Markdowntown",
            dependencies: [.product(name: "Markdown", package: "swift-markdown")]),
        .testTarget(
            name: "MarkdowntownTests",
            dependencies: ["Markdowntown"]),
    ]
)
