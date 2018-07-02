import XCTest
@testable import RNGExtension

struct DummyRNG: RandomNumberGenerator {
    static var `default` = DummyRNG.init()
    var state: UInt32 = 0
    
    mutating func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        state += 123456789
        return T(state)
    }
}

final class RNGExtensionTests: XCTestCase {
    func testMutating() {
        print(DummyRNG.default.uniform.next() as Float)
        print(DummyRNG.default.uniform.next() as Float)
        print(DummyRNG.default.uniform.next() as Float)
        
        var rng = DummyRNG.default
        
        print(rng.uniform.next() as Float)
        print(rng.uniform.next() as Float)
        print(rng.uniform.next() as Float)
        
        var uniform = rng.uniform
        
        print(uniform.next() as Float)
        print(uniform.next() as Float)
        print(uniform.next() as Float)
    }
    
    func testUniform() {
        let count = 100000
        let array = (0..<count).map { _ in Random.default.uniform.next() as Float }
        let mean = array.reduce(0, +) / Float(count)
        
        XCTAssertGreaterThanOrEqual(array.min()!, 0)
        XCTAssertLessThan(array.max()!, 1)
        XCTAssertEqual(mean, 0.5, accuracy: 1e-2)
    }
    
    func testNormal() {
        let count = 100000
        let array = (0..<count).map { _ in Random.default.normal.next() as Float }
        let mean = array.reduce(0, +) / Float(count)
        let std = sqrt(array.map { pow($0 - mean, 2) }.reduce(0, +) / Float(count))
        
        XCTAssertEqual(mean, 0, accuracy: 1e-2)
        XCTAssertEqual(std, 1, accuracy: 1e-2)
    }
}
