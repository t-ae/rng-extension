import XCTest
import RNGExtension

class PerformanceTests: XCTestCase {
    func testNormal() {
        measure {
            for _ in 0..<1_000_000 {
                _ = Random.default.normal.next(mu: 0, sigma: 1) as Double
            }
        }
    }
}
