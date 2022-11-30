@testable import CodableBetter
import XCTest

class CustomDateCodableValueTests: XCTestCase {
    func testDecodingAndEncodingISO8601DateString() throws {
        struct Fixture: Codable {
            @DateValue<ISO8601Strategy> var iso8601: Date
        }
        let jsonData = #"{"iso8601": "1996-12-19T16:39:57-08:00"}"#.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.iso8601, Date(timeIntervalSince1970: 851_042_397))
    }

    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    func testDecodingAndEncodingISO8601DateStringWithFractionalSeconds() throws {
        struct Fixture: Codable {
            @DateValue<ISO8601WithFractionalSecondsStrategy> var iso8601: Date
            @DateValue<ISO8601WithFractionalSecondsStrategy> var iso8601Short: Date
        }
        let jsonData = """
        {
          "iso8601": "1996-12-19T16:39:57.123456Z",
          "iso8601Short": "1996-12-19T16:39:57.000Z-08:00"
        }
        """.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.iso8601Short, Date(timeIntervalSince1970: 851_013_597.0))
        XCTAssertEqual(fixture.iso8601, Date(timeIntervalSince1970: 851_013_597.123))
    }

    func testDecodingAndEncodingRFC3339DateString() throws {
        struct Fixture: Codable {
            @DateValue<RFC3339Strategy> var rfc3339Date: Date
        }
        let jsonData = #"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"#.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.rfc3339Date, Date(timeIntervalSince1970: 851_042_397))
    }

    func testDecodingAndEncodingRFC2822DateString() throws {
        struct Fixture: Codable {
            @DateValue<RFC2822Strategy> var rfc2822Date: Date
        }
        let jsonData = #"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"#.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.rfc2822Date, Date(timeIntervalSince1970: 1_577_486_632))
    }

    func testDecodingAndEncodingUTCTimestamp() throws {
        struct Fixture: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }
        let jsonData = #"{"timestamp": 851042397.0}"#.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.timestamp, Date(timeIntervalSince1970: 851_042_397))
    }

    func testDecodingAndEncodingYearMonthDateString() throws {
        struct Fixture: Codable {
            @DateValue<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = #"{"ymd": "1996-12-19"}"#.data(using: .utf8)!

        let fixture = try JSONDecoder().decode(Fixture.self, from: jsonData)
        XCTAssertEqual(fixture.ymd, Date(timeIntervalSince1970: 850_953_600))
    }
}
