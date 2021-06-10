// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "RSTextViewMaster",
	platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "RSTextViewMaster",            
            targets: ["RSTextViewMaster"]),
    ],
    targets: [
        .target(
            name: "RSTextViewMaster",
			path: "Sources"
		)
    ],
	swiftLanguageVersions: [.v5]
)
