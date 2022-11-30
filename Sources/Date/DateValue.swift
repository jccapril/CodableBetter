import Foundation

/// Decodes and encodes dates using a strategy type.
///
/// `@DateValue` decodes dates using a `DateValueCodableStrategy` which provides custom decoding and encoding functionality.
@propertyWrapper
public struct DateValue<Formatter: DateValueCodableStrategy> {
    private let value: Formatter.RawValue
    public var wrappedValue: Date

    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        value = Formatter.encode(wrappedValue)
    }
}

extension DateValue: Decodable where Formatter.RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        value = try Formatter.RawValue(from: decoder)
        wrappedValue = try Formatter.decode(value)
    }
}

extension DateValue: Encodable where Formatter.RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
