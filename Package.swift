// swift-tools-version:4.0
import PackageDescription


let package = Package(
    name: "OutlawAppKit",
    products: [
        .library(name: "OutlawAppKit", targets: ["OutlawAppKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Molbie/Outlaw.git", from: "4.0.0"),
        .package(url: "https://github.com/Molbie/Outlaw-CoreGraphics.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "OutlawAppKit", dependencies: ["Outlaw", "OutlawCoreGraphics"]),
        .testTarget(name: "OutlawAppKitTests", dependencies: ["OutlawAppKit"])
    ]
)
