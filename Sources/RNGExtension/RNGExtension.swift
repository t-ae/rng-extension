import Foundation

public struct Uniform {
    var base: RandomNumberGenerator
    
    init(base: RandomNumberGenerator) {
        self.base = base
    }
    
    /// Returns a value from uniform [low, high) distribution.
    public mutating func next(low: Float, high: Float) -> Float {
        let uint32: UInt32 = base.next()
        
        return (high - low) * (Float(bitPattern: uint32 >> 9 | 0x3f80_0000) - 1) + low
    }
    
    /// Returns a value from uniform [0, 1) distribution.
    public mutating func next() -> Float {
        return next(low: 0, high: 1)
    }
    
    /// Returns a value from uniform [low, high) distribution.
    public mutating func next(low: Double, high: Double) -> Double {
        let uint64: UInt64 = base.next()
        
        return (high - low) * (Double(bitPattern: uint64 >> 12 | 0x3ff0_0000_0000_0000) - 1) + low
    }
    
    /// Returns a value from uniform [0, 1) distribution.
    public mutating func next() -> Double {
        return next(low: 0, high: 1)
    }
}

public struct Normal {
    var base: Uniform
    init(base: Uniform) {
        self.base = base
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    public mutating func next(mu: Float, sigma: Float) -> Float {
        return sqrt(-2*log(base.next(low: Float.leastNormalMagnitude, high: 1))) * sin(base.next(low: 0, high: 2*Float.pi))
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Float {
        return next(mu: 0, sigma: 1)
    }
    
    /// Returns a value from N(mu, sigma^2) distribution.
    public mutating func next(mu: Double, sigma: Double) -> Double {
        return sqrt(-2*log(base.next(low: Double.leastNormalMagnitude, high: 1))) * sin(base.next(low: 0, high: 2*Double.pi))
    }
    
    /// Returns a value from N(0, 1) distribution.
    public mutating func next() -> Double {
        return next(mu: 0, sigma: 1)
    }
}

extension RandomNumberGenerator {
    public var uniform: Uniform {
        get {
            return Uniform(base: self)
        }
        set {
            self = newValue.base as! Self
        }
    }
    
    public var normal: Normal {
        get {
            return Normal(base: uniform)
        }
        set {
            self.uniform = newValue.base
        }
    }
}
