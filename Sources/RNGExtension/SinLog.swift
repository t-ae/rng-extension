import Foundation

protocol SinLog: BinaryFloatingPoint {
    static func sin(_ x: Self) -> Self
    static func log(_ x: Self) -> Self
}

extension Float: SinLog {
    static func sin(_ x: Float) -> Float {
        return Foundation.sin(x)
    }
    static func log(_ x: Float) -> Float {
        return Foundation.log(x)
    }
}

extension Double: SinLog {
    static func sin(_ x: Double) -> Double {
        return Foundation.sin(x)
    }
    static func log(_ x: Double) -> Double {
        return Foundation.log(x)
    }
}

extension CGFloat: SinLog {
    static func sin(_ x: CGFloat) -> CGFloat {
        return Foundation.sin(x)
    }
    static func log(_ x: CGFloat) -> CGFloat {
        return Foundation.log(x)
    }
}

extension Float80: SinLog {
    static func sin(_ x: Float80) -> Float80 {
        return Foundation.sin(x)
    }
    static func log(_ x: Float80) -> Float80 {
        return Foundation.log(x)
    }
}
