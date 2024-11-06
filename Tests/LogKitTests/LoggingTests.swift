import XCTest
@testable import LogKit


final class LogKitTests: XCTestCase {

    func testOrderedArrayMerge() {
        let array1 = ["1", "2", "3"]
        let array2 = ["2", "3", "4", "5"]
        
        let merged = array1.mergedWithUniqueValues(from: array2)
        
        XCTAssertEqual(merged, ["1", "2", "3", "4", "5"])
        
        let array3 = ["apple", "banana", "orange", "lime"]
        let array4 = ["banana", "grape", "kiwi"]

        let merged2 = array3.mergedWithUniqueValues(from: array4)
        XCTAssertEqual(merged2, ["apple", "banana", "orange", "lime", "grape", "kiwi"])
        
    }
    
}
