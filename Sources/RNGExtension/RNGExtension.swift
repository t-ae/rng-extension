import Foundation

extension RandomNumberGenerator {
    mutating func next12() -> Float {
        let uint32 = next() as UInt32
        return Float(bitPattern: uint32 >> 9 | 0x3f80_0000)
    }
    
    mutating  func next12() -> Double {
        let uint64 = next() as UInt64
        return Double(bitPattern: uint64 >> 12 | 0x3ff0_0000_0000_0000)
    }
}

public struct Uniform<Base: RandomNumberGenerator> {
    public var base: Base
    
    init(base: Base) {
        self.base = base
    }
    
    /// Returns a value from uniform [low, high) distribution.
    public mutating func next(_ range: Range<Float>) -> Float {
        return (range.upperBound - range.lowerBound) * (base.next12() - 1) + range.lowerBound
    }
    
    /// Returns a value from uniform [0, 1) distribution.
    public mutating func next() -> Float {
        return next(0..<1)
    }
    
    /// Returns a value from uniform [low, high) distribution.
    public mutating func next(_ range: Range<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * (base.next12() - 1) + range.lowerBound
    }
    
    /// Returns a value from uniform [0, 1) distribution.
    public mutating func next() -> Double {
        return next(0..<1)
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
        let x: Float = sqrt(-2*log1p(-base.next12()+1))
        let y: Float = sin(2 * .pi * base.next12())
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
        let x: Double = sqrt(-2*log1p(-base.next12()+1))
        let y: Double = sin(2 * .pi * base.next12())
        return sigma * x * y + mu
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Double {
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
