import Foundation

/// Decodes Codable values into their respective preferred types.
///
/// `@LosslessValueCodable` attempts to decode Codable types into their preferred order while preserving the data in the most lossless format.
///
/// The preferred type order is provided by a generic `LosslessDecodingStrategy` that provides an ordered list of `losslessDecodableTypes`.
@propertyWrapper
public struct LosslessValueCodable<Strategy: LosslessDecodingStrategy>: Codable {
    private let type: LosslessStringCodable.Type

    public var wrappedValue: Strategy.Value

    public init(wrappedValue: Strategy.Value) {
        self.wrappedValue = wrappedValue
        type = Strategy.Value.self
    }

    public init(from decoder: Decoder) throws {
        do {
            wrappedValue = try Strategy.Value(from: decoder)
            type = Strategy.Value.self
        } catch {
            guard
                let rawValue = Strategy.losslessDecodableTypes.lazy.compactMap({ $0(decoder) }).first,
                let value = Strategy.Value("\(rawValue)")
            else { throw error }

            wrappedValue = value
            type = Swift.type(of: rawValue)
        }
    }

    public func encode(to encoder: Encoder) throws {
        let string = String(describing: wrappedValue)

        guard let original = type.init(string) else {
            let description = "Unable to encode '\(wrappedValue)' back to source type '\(type)'"
            throw EncodingError.invalidValue(string, .init(codingPath: [], debugDescription: description))
        }

        try original.encode(to: encoder)
    }
}

extension LosslessValueCodable: Equatable where Strategy.Value: Equatable {
    public static func == (lhs: LosslessValueCodable<Strategy>, rhs: LosslessValueCodable<Strategy>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}

extension LosslessValueCodable: Hashable where Strategy.Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(wrappedValue)
    }
}

public struct LosslessDefaultStrategy<Value: LosslessStringCodable>: LosslessDecodingStrategy {
    public static var losslessDecodableTypes: [(Decoder) -> LosslessStringCodable?] {
        @inline(__always)
        func decode<T: LosslessStringCodable>(_: T.Type) -> (Decoder) -> LosslessStringCodable? {
            { try? T(from: $0) }
        }

        return [
            decode(String.self),
            decode(Bool.self),
            decode(Int.self),
            decode(Int8.self),
            decode(Int16.self),
            decode(Int64.self),
            decode(UInt.self),
            decode(UInt8.self),
            decode(UInt16.self),
            decode(UInt64.self),
            decode(Double.self),
            decode(Float.self),
        ]
    }
}

public struct LosslessBooleanStrategy<Value: LosslessStringCodable>: LosslessDecodingStrategy {
    public static var losslessDecodableTypes: [(Decoder) -> LosslessStringCodable?] {
        @inline(__always)
        func decode<T: LosslessStringCodable>(_: T.Type) -> (Decoder) -> LosslessStringCodable? {
            { try? T(from: $0) }
        }

        @inline(__always)
        func decodeBoolFromNSNumber() -> (Decoder) -> LosslessStringCodable? {
            { (try? Int(from: $0)).flatMap { Bool(exactly: NSNumber(value: $0)) } }
        }

        return [
            decode(String.self),
            decodeBoolFromNSNumber(),
            decode(Bool.self),
            decode(Int.self),
            decode(Int8.self),
            decode(Int16.self),
            decode(Int64.self),
            decode(UInt.self),
            decode(UInt8.self),
            decode(UInt16.self),
            decode(UInt64.self),
            decode(Double.self),
            decode(Float.self),
        ]
    }
}
