import Foundation

public struct Uniform<Base: RandomNumberGenerator> {
    public var base: Base
    
    init(base: Base) {
        self.base = base
    }
    
    /// Returns a value from uniform distribution.
    /// - Parameter range: Range of uniform distribution.
    public mutating func next<T: BinaryFloatingPoint>(in range: Range<T>) -> T
        where T.RawSignificand : FixedWidthInteger,
        T.RawSignificand.Stride : SignedInteger,
        T.RawSignificand.Magnitude : UnsignedInteger {
            return T.random(in: range, using: &base)
    }
    
    /// Returns a value from uniform distribution.
    /// - Parameter range: Range of uniform distribution
    public mutating func next<T: BinaryFloatingPoint>(in range: ClosedRange<T>) -> T
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
    
    mutating func next_generic<T: SinLog>(mu: T, sigma: T) -> T
        where T.RawSignificand : FixedWidthInteger,
        T.RawSignificand.Stride : SignedInteger,
        T.RawSignificand.Magnitude : UnsignedInteger {
            precondition(sigma >= 0, "Invalid argument: `sigma` must not be less than 0.")
            
            // Box-Muller's method
            let x: T = sqrt(-2 * .log(.random(in: .leastNormalMagnitude..<1, using: &base)))
            let y: T = .sin(.random(in: .leastNormalMagnitude..<2 * .pi, using: &base))
            return sigma * x * y + mu
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Float, sigma: Float) -> Float {
        return next_generic(mu: mu, sigma: sigma)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Double, sigma: Double) -> Double {
        return next_generic(mu: mu, sigma: sigma)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: CGFloat, sigma: CGFloat) -> CGFloat {
        return next_generic(mu: mu, sigma: sigma)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    /// - Precondition:
    ///   - `sigma` >= 0
    public mutating func next(mu: Float80, sigma: Float80) -> Float80 {
        return next_generic(mu: mu, sigma: sigma)
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
