@testable import CodableBetter
import XCTest

class DefaultInitTests: XCTestCase {
    struct Fixture: Codable {
        @DefaultInitialize var text: String
        @DefaultInitialize var integer: Int
        @DefaultInitialize var array: [Int]
        @DefaultInitialize var dict: [String: Int]
    }

    func testDecodingFailableToDefaultInitValue() throws {
        let json = Data(#"{ "text": null, "integer": null, "array": null, "dict": null }"#.utf8)
        let fixture = try JSONDecoder().decode(Fixture.self, from: json)

        XCTAssertEqual(fixture.text, "")
        XCTAssertEqual(fixture.integer, 0)
        XCTAssertEqual(fixture.array, [])
        XCTAssertEqual(fixture.dict, [:])
    }
}

extension String: Initializable {}
extension Int: Initializable {}
extension Array: Initializable where Element: Codable {}
extension Dictionary: Initializable where Key: Codable, Value: Codable {}
