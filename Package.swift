// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
  name: "GoogleTagManager",
  platforms: [.iOS(.v15), .macOS(.v10_15)],
  products: [
    .library(
      name: "GoogleTagManager",
      targets: ["GoogleTagManagerTarget"]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/firebase/firebase-ios-sdk.git",
      "11.0.0" ..< "13.0.0"
    ),
  ],
  targets: [
    .target(
      name: "GoogleTagManagerTarget",
      dependencies: [
        "GoogleTagManager",
        .product(
          name: "FirebaseAnalytics",
          package: "firebase-ios-sdk",
          condition: .when(platforms: [.iOS])
        ),
      ],
      path: "GoogleTagManagerWrapper",
      linkerSettings: [
        .linkedLibrary("sqlite3"),
        .linkedLibrary("z"),
        .linkedFramework("AdSupport"),
        .linkedFramework("CoreData"),
        .linkedFramework("CoreTelephony"),
        .linkedFramework("JavaScriptCore"),
        .linkedFramework("SystemConfiguration"),
        .linkedFramework("UIKit"),
      ]
    ),
    .binaryTarget(
      name: "GoogleTagManager",
      url: "https://dl.google.com/firebase/ios/tagmanager/swiftpm/9.0.0/GoogleTagManager.zip",
      checksum: "6e4bce252764ab4f56f2ebc01e7f24b49f333c31847a9734e81e635c08a934b0"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
