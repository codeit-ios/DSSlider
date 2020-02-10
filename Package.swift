// swift-tools-version:5.0
//
//  Package.swift
//

import PackageDescription

let package = Package(name: "DSSlider",
                      platforms: [.macOS(.v10_12)],
                      products: [.library(name: "DSSlider",
                                          targets: ["DSSlider"])],
                      targets: [.target(name: "DSSlider",
                                        path: "Source")],
                      swiftLanguageVersions: [.v5])
