// swift-tools-version:5.3
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
  platforms: [.iOS(.v11)],
  products: [
    .library(
      name: "GoogleTagManager",
      targets: ["GoogleTagManagerTarget"]
    ),
  ],
  dependencies: [
    .package(
      name: "Firebase",
      url: "https://github.com/firebase/firebase-ios-sdk.git",
      "9.0.0" ..< "11.0.0"
    ),
    .package(
      name: "GoogleUtilities",
      url: "https://github.com/google/GoogleUtilities.git",
      "7.11.0" ..< "8.0.0"
    ),
  ],
  targets: [
    .target(
      name: "GoogleTagManagerTarget",
      dependencies: [
        "GoogleTagManager",
        "GoogleAnalytics",
        .product(name: "FirebaseAnalytics", package: "Firebase"),
        .product(name: "GULUserDefaults", package: "GoogleUtilities"),
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
      url: "https://dl.google.com/firebase/ios/tagmanager/swiftpm/7.4.5/GoogleTagManager.zip",
      checksum: "63e9988214e0f6b97c219040fbb48426d4d6a0040536e9a1b6757cbd7094c2f8"
    ),
    .binaryTarget(
      name: "GoogleAnalytics",
      url: "https://dl.google.com/firebase/ios/tagmanager/swiftpm/7.4.6/GoogleAnalytics.zip",
      checksum: "be0a4b8012739c5256424ba128f8f495c4ba75698ad1f239dc3dbb656aa450a3"
    ),
  ],
  cLanguageStandard: .c99,
  cxxLanguageStandard: CXXLanguageStandard.gnucxx14
)
