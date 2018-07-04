import XCTest
import RNGExtension

struct DummyRNG: RandomNumberGenerator {
    static var `default` = DummyRNG.init()
    var state: UInt32 = 0
    
    mutating func next<T>() -> T where T : FixedWidthInteger, T : UnsignedInteger {
        state += 123456789
        return T(state)
    }
}

final class RNGExtensionTests: XCTestCase {
    func testMutation() {
        print(DummyRNG.default.uniform.next(in: 0..<1) as Float)
        print(DummyRNG.default.uniform.next(in: 0..<1) as Float)
        print(DummyRNG.default.uniform.next(in: 0..<1) as Float)
        
        var rng = DummyRNG.default
        
        print(rng.uniform.next(in: 0..<1) as Float)
        print(rng.uniform.next(in: 0..<1) as Float)
        print(rng.uniform.next(in: 0..<1) as Float)
        
        var uniform = rng.uniform
        print(uniform.next(in: 0..<1) as Float)
        print(uniform.next(in: 0..<1) as Float)
        print(uniform.next(in: 0..<1) as Float)
        
        // This generates same sequence as above...
        var uniform2 = rng.uniform
        
        print(uniform2.next(in: 0..<1) as Float)
        print(uniform2.next(in: 0..<1) as Float)
        print(uniform2.next(in: 0..<1) as Float)
    }
    
    func testUniform() {
        do {
            let count = 1000000
            let array = (0..<count).map { _ in Random.default.uniform.next(in: 0..<1) as Float }
            let mean = array.reduce(0, +) / Float(count)
            
            XCTAssertGreaterThanOrEqual(array.min()!, 0)
            XCTAssertLessThan(array.max()!, 1)
            XCTAssertEqual(mean, 0.5, accuracy: 1e-2)
        }
        do {
            let count = 1000000
            let array = (0..<count).map { _ in Random.default.uniform.next(in: -10..<20) as Double }
            let mean = array.reduce(0, +) / Double(count)
            
            XCTAssertGreaterThanOrEqual(array.min()!, -10)
            XCTAssertLessThan(array.max()!, 20)
            XCTAssertEqual(mean, 5, accuracy: 1e-2)
        }
    }
    
    func testNormal() {
        do {
            let count = 1000000
            let array = (0..<count).map { _ in Random.default.normal.next(mu: 0, sigma: 1) as Float }
            let mean = array.reduce(0, +) / Float(count)
            let std = sqrt(array.map { pow($0 - mean, 2) }.reduce(0, +) / Float(count))
            
            XCTAssertEqual(mean, 0, accuracy: 1e-2)
            XCTAssertEqual(std, 1, accuracy: 1e-2)
        }
        do {
            let count = 1000000
            let array = (0..<count).map { _ in Random.default.normal.next(mu: 1, sigma: 3) as Double }
            let mean = array.reduce(0, +) / Double(count)
            let std = sqrt(array.map { pow($0 - mean, 2) }.reduce(0, +) / Double(count))
            
            XCTAssertEqual(mean, 1, accuracy: 1e-2)
            XCTAssertEqual(std, 3, accuracy: 1e-2)
        }
    }
    
    var allTests = [
        ("testMutation", testMutation),
        ("testUniform", testUniform),
        ("testNormal", testNormal)
    ]
}
