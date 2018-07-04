# RNGExtension

Swift exntension for `RandomNumberGenerator`.

## Description
Any `RandomNumberGenerator` gets `uniform: Uniform` and `normal: Normal`.
`Uniform` and `Normal` have several `next` functions.

## Example

```swift
// Get random float number from uniform distribution [10, 20)
let float: Float = Random.default.uniform.next(in: 10..<20)
/// Get random double number from normal distribution N(1, 3^2)
let double: Double = Random.default.normal.next(mu: 1, sigma: 3)
```

## Installation

Add the following setting to your `Package.swift`.

```swift
let package = Package(
    name: "Project",
    dependencies: [
        ...
        .package(url: "https://github.com/t-ae/rng-extension.git", from: "1.0.0"),
    ],
    targets: [
      .target(name: "Project", dependencies: ["RNGExtension", ... ])
    ]
)
```


