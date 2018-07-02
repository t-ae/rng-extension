# RNGExtension

Swift exntension for `RandomNumberGenerator`.

## Description
Any `RandomNumberGenerator` gets `uniform: Uniform` and `normal: Normal`.
`Uniform` and `Normal` have several `next` functions.

## Example

```swift
// Get random float number from uniform distribution [10, 20)
let float = Random.default.uniform.next(low: 10, high: 20)
/// Get random double number from normal distribution N(1, 3^2)
let double = Random.default.normal.next(mu: 1, sigma: 3)
```