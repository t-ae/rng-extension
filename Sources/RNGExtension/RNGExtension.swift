import Foundation

public struct Uniform<Base: RandomNumberGenerator> {
    public var base: Base
    
    init(base: Base) {
        self.base = base
    }
    
    /// Returns a value from uniform distribution.
    /// - Parameter range: Range of uniform distribution, default: 0..<1
    public mutating func next<T: BinaryFloatingPoint>(_ range: Range<T> = 0..<1) -> T
        where T.RawSignificand : FixedWidthInteger,
        T.RawSignificand.Stride : SignedInteger,
        T.RawSignificand.Magnitude : UnsignedInteger {
            return T.random(in: range, using: &base)
    }
    
    /// Returns a value from uniform distribution.
    /// - Parameter range: Range of uniform distribution
    public mutating func next<T: BinaryFloatingPoint>(_ range: ClosedRange<T>) -> T
        where T.RawSignificand : FixedWidthInteger,
        T.RawSignificand.Stride : SignedInteger,
        T.RawSignificand.Magnitude : UnsignedInteger {
            return T.random(in: range, using: &base)
    }
}

public struct Normal<Base: RandomNumberGenerator> {
    public var base: Base
    
    init(base: Base) {
        self.base = base
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Float, sigma: Float) -> Float {
        precondition(sigma >= 0, "Invalid argument: `sigma` must not be less than 0.")
        let x: Float = sqrt(-2*log(.random(in: .leastNormalMagnitude..<1, using: &base)))
        let y: Float = sin(.random(in: .leastNormalMagnitude..<2 * .pi, using: &base))
        return sigma * x * y + mu
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Float {
        return next(mu: 0, sigma: 1)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Double, sigma: Double) -> Double {
        precondition(sigma >= 0, "Invalid argument: `sigma` must not be less than 0.")
        let x: Double = sqrt(-2*log(.random(in: .leastNormalMagnitude..<1, using: &base)))
        let y: Double = sin(.random(in: .leastNormalMagnitude..<2 * .pi, using: &base))
        return sigma * x * y + mu
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Double {
        return next(mu: 0, sigma: 1)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: CGFloat, sigma: CGFloat) -> CGFloat {
        precondition(sigma >= 0, "Invalid argument: `sigma` must not be less than 0.")
        let x: CGFloat = sqrt(-2*log(.random(in: .leastNormalMagnitude..<1, using: &base)))
        let y: CGFloat = sin(.random(in: .leastNormalMagnitude..<2 * .pi, using: &base))
        return sigma * x * y + mu
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> CGFloat {
        return next(mu: 0, sigma: 1)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Float80, sigma: Float80) -> Float80 {
        precondition(sigma >= 0, "Invalid argument: `sigma` must not be less than 0.")
        let x: Float80 = sqrt(-2*log(.random(in: .leastNormalMagnitude..<1, using: &base)))
        let y: Float80 = sin(.random(in: .leastNormalMagnitude..<2 * .pi, using: &base))
        return sigma * x * y + mu
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Float80 {
        return next(mu: 0, sigma: 1)
    }
}

extension RandomNumberGenerator {
    public var uniform: Uniform<Self> {
        get {
            return Uniform(base: self)
        }
        set {
            self = newValue.base
        }
    }
    
    public var normal: Normal<Self> {
        get {
            return Normal(base: self)
        }
        set {
            self = newValue.base
        }
    }
}
