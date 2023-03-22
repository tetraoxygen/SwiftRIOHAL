// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRIOHAL",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftRIOHAL",
            targets: [
                "SwiftRIOHAL"
            ]),
        .library(name: "CRIOHAL", targets: [
            "CRIOHAL"
        ])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "CRIOHAL", cxxSettings: [
            .headerSearchPath("../../allwpilib/wpiutil/src/main/native/include"),
            .headerSearchPath("../../allwpilib/wpiutil/src/main/native/thirdparty/llvm/include"),
            .headerSearchPath("../../allwpilib/wpiutil/src/main/native/thirdparty/fmtlib/include"),
            .headerSearchPath("../../ni-libraries/src/include"),
            .headerSearchPath("Implementation/athenaincludes"),
        ]),
        .target(
            name: "SwiftRIOHAL",
            dependencies: [
                "CRIOHAL"
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-static-stdlib"
                ])
            ]
        ),
        .testTarget(
            name: "SwiftRIOHALTests",
            dependencies: ["SwiftRIOHAL"]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .gnucxx20
)
